#!/bin/sh

set -e

# Allow some ENV variables to be customized
if [[ -z "$SLUG" ]]; then
	SLUG=${GITHUB_REPOSITORY#*/}
fi

# Does it even make sense for VERSION to be editable in a workflow definition?
if [[ -z "$VERSION" ]]; then
	VERSION=${GITHUB_REF#refs/tags/}
fi

if [[ -z "$ASSETS_DIR" ]]; then
	ASSETS_DIR="assets/dotorg"
fi

SVN_URL="http://plugins.svn.wordpress.org/${SLUG}/"
SVN_DIR="${GITHUB_WORKSPACE}/svn-${SLUG}"

# Checkout just trunk and assets for efficiency
# Tagging will be handled on the SVN level
echo "\nChecking out .org repository...\n"
svn checkout --depth immediates $SVN_URL $SVN_DIR
cd $SVN_DIR
svn update --set-depth infinity assets
svn update --set-depth infinity trunk

echo "\nCopying files...\n"

# Copy from current branch to /trunk, excluding dotorg assets
rsync -r --exclude "$GITHUB_WORKSPACE/$ASSETS_DIR" "$GITHUB_WORKSPACE/*" trunk/

# Copy dotorg assets to /assets
rsync -r "$GITHUB_WORKSPACE/$ASSETS_DIR/*" assets/

# Add everything and commit to SVN
# The force flag ensures we recurse into subdirectories even if they are already added
echo "\nCommitting files...\n"
svn add * --force
svn commit -m "Update to version $VERSION from GitHub"

# SVN tag to VERSION
echo "\nTagging version...\n"
svn cp "^/trunk" "^/tags/$VERSION" -m "Tag $VERSION"

echo "\nPlugin deployed!\n"
