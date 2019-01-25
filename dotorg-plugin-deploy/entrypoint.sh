#!/bin/bash

echo "Let's go!"

set -eo pipefail

# Ensure SVN username and password are set
# IMPORTANT: secrets are accessible by anyone with write access to the repository!
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
echo "SLUG is $SLUG"

# Does it even make sense for VERSION to be editable in a workflow definition?
if [[ -z "$VERSION" ]]; then
	VERSION=${GITHUB_REF#refs/tags/}
fi
echo "VERSION is $VERSION"

if [[ -z "$ASSETS_DIR" ]]; then
	ASSETS_DIR="assets/dotorg"
fi
echo "ASSETS_DIR is $ASSETS_DIR"

SVN_URL="http://plugins.svn.wordpress.org/${SLUG}/"
SVN_DIR="/github/svn-${SLUG}"

# Checkout just trunk and assets for efficiency
# Tagging will be handled on the SVN level
echo "Checking out .org repository..."
svn checkout --depth immediates $SVN_URL $SVN_DIR
cd $SVN_DIR
svn update --set-depth infinity assets
svn update --set-depth infinity trunk

echo "Copying files..."

# Copy from current branch to /trunk, excluding dotorg assets
rsync -r --exclude "$GITHUB_WORKSPACE/$ASSETS_DIR" "$GITHUB_WORKSPACE/" trunk/

# Copy dotorg assets to /assets
rsync -r "$GITHUB_WORKSPACE/$ASSETS_DIR/" assets/

# Add everything and commit to SVN
# The force flag ensures we recurse into subdirectories even if they are already added
echo "Committing files..."
svn add * --force
svn commit --non-interactive --username SVN_USERNAME --password SVN_PASSWORD -m "Update to version $VERSION from GitHub"

# SVN tag to VERSION
echo "Tagging version..."
svn cp --non-interactive --username SVN_USERNAME --password SVN_PASSWORD "^/trunk" "^/tags/$VERSION" -m "Tag $VERSION"

echo "Plugin deployed!"
