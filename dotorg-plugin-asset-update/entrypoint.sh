#!/bin/bash

# Note that this does not use pipefail because if the grep later
# doesn't match I want to be able to show an error first
set -eo

# Ensure SVN username and password are set
# IMPORTANT: while secrets are encrypted and not viewable in the GitHub UI,
# they are by necessity provided as plaintext in the context of the Action,
# so do not echo or use debug mode unless you want your secrets exposed!
if [[ -z "$SVN_USERNAME" ]]; then
	echo "Set the SVN_USERNAME secret"
	exit 1
fi

if [[ -z "$SVN_PASSWORD" ]]; then
	echo "Set the SVN_PASSWORD secret"
	exit 1
fi

# Allow some ENV variables to be customized
if [[ -z "$SLUG" ]]; then
	SLUG=${GITHUB_REPOSITORY#*/}
fi
echo "ℹ︎ SLUG is $SLUG"

if [[ -z "$ASSETS_DIR" ]]; then
	ASSETS_DIR=".wordpress-org"
fi
echo "ℹ︎ ASSETS_DIR is $ASSETS_DIR"

SVN_URL="http://plugins.svn.wordpress.org/${SLUG}/"
SVN_DIR="/github/svn-${SLUG}"

# Checkout just trunk and assets for efficiency
# Stable tag will come later, if applicable
echo "➤ Checking out .org repository..."
svn checkout --depth immediates "$SVN_URL" "$SVN_DIR"
cd "$SVN_DIR"
svn update --set-depth infinity assets
svn update --set-depth infinity trunk

echo "➤ Copying files..."
cd "$GITHUB_WORKSPACE"

# "Export" a cleaned copy to a temp directory
TMP_DIR="/github/archivetmp"
mkdir "$TMP_DIR"

git config --global user.email "10upbot+github@10up.com"
git config --global user.name "10upbot on GitHub"

# If there's no .gitattributes file, write a default one into place
if [[ ! -e "$GITHUB_WORKSPACE/.gitattributes" ]]; then
	cat > "$GITHUB_WORKSPACE/.gitattributes" <<-EOL
	/$ASSETS_DIR export-ignore
	/.gitattributes export-ignore
	/.gitignore export-ignore
	/.github export-ignore
	EOL

	# Ensure we are in the $GITHUB_WORKSPACE directory, just in case
	# The .gitattributes file has to be committed to be used
	# Just don't push it to the origin repo :)
	git add .gitattributes && git commit -m "Add .gitattributes file"
fi

# This will exclude everything in the .gitattributes file with the export-ignore flag
git archive HEAD | tar x --directory="$TMP_DIR"

cd "$SVN_DIR"

# Copy from clean copy to /trunk, excluding dotorg assets
# The --delete flag will delete anything in destination that no longer exists in source
rsync -rc "$TMP_DIR/" trunk/ --delete

# Copy dotorg assets to /assets
rsync -rc "$GITHUB_WORKSPACE/$ASSETS_DIR/" assets/ --delete

echo "➤ Preparing files..."

svn status

if [[ -z $(svn stat) ]]; then
	echo "🛑 Nothing to deploy!"
	exit 78
# Check if there is more than just the readme.txt modified in trunk
# The leading whitespace in the pattern is important
# so it doesn't match potential readme.txt in subdirectories!
elif svn stat trunk | grep -qvi ' trunk/readme.txt$'; then
	echo "🛑 Other files have been modified; changes not deployed"
	exit 1
fi

# Readme also has to be updated in the .org tag
echo "➤ Preparing stable tag..."
STABLE_TAG=$(grep -m 1 "^Stable tag:" "$TMP_DIR/readme.txt" | tr -d '\r\n' | awk -F ' ' '{print $NF}')

if [ -z "$STABLE_TAG" ]; then
    echo "ℹ︎ Could not get stable tag from readme.txt";
	HAS_STABLE=1
else
	echo "ℹ︎ STABLE_TAG is $STABLE_TAG"

	if svn info "^/$SLUG/tags/$STABLE_TAG" > /dev/null 2>&1; then
		svn update --set-depth infinity "tags/$STABLE_TAG"

		# Not doing the copying in SVN for the sake of easy history
		rsync -c "$TMP_DIR/readme.txt" "tags/$STABLE_TAG/"
	else
		echo "ℹ︎ Tag $STABLE_TAG not found"
	fi
fi

# Add everything and commit to SVN
# The force flag ensures we recurse into subdirectories even if they are already added
# Suppress stdout in favor of svn status later for readability
svn add . --force > /dev/null

# SVN delete all deleted files
# Also suppress stdout here
svn status | grep '^\!' | sed 's/! *//' | xargs -I% svn rm % > /dev/null

# Now show full SVN status
svn status

echo "➤ Committing files..."
svn commit -m "Updating readme/assets from GitHub" --no-auth-cache --non-interactive  --username "$SVN_USERNAME" --password "$SVN_PASSWORD"

echo "✓ Plugin deployed!"

echo "⚠️ Please consider migrating to https://github.com/10up/action-wordpress-plugin-asset-update for the latest version of this Action"
