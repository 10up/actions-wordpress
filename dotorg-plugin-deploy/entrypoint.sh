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

SVN_URL="http://plugins.svn.wordpress.org/${SLUG}/"
SVN_DIR="${GITHUB_WORKSPACE}/svn-${SLUG}"

# Checkout stable branch of repo - can you do this inside GITHUB_WORKSPACE?
# Do I need to go back to master afterward since more actions can run?
# Does this need a customizable ENV?

# Checkout just trunk and assets for efficiency
# Tagging will be handled on the SVN level
echo "\Checking out .org repository...\n"
svn checkout --depth immediates $SVN_URL $SVN_DIR
cd $SVN_DIR
svn update --set-depth infinity assets
svn update --set-depth infinity trunk

# Copy from stable branch to /trunk, excluding dotorg assets

# Copy dotorg assets to /assets

# Add everything and commit to SVN

# SVN tag to VERSION

