FROM debian:stable-slim

LABEL "com.github.actions.name"="WordPress Plugin Readme Update"
LABEL "com.github.actions.description"="Deploy readme updates to the WordPress Plugin Repository"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

LABEL maintainer="Helen Hou-Sandí <helen.y.hou@gmail.com>"
LABEL version="1.0.0"
LABEL repository="http://github.com/helen/actions-wordpress"

RUN apt-get update \
	&& apt-get install -y subversion rsync git \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& git config --global user.email "10upbot+github@10up.com" \
	&& git config --global user.name "10upbot on GitHub"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
