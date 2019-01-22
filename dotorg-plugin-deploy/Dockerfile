FROM debian:stable-slim

LABEL "com.github.actions.name"="WordPress.org Plugin Deploy"
LABEL "com.github.actions.description"="Deploy to the wordpress.org plugin repository"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

LABEL maintainer="Helen Hou-Sandí <helen.y.hou@gmail.com>"
LABEL version="1.0.0"
LABEL homepage="https://github.com/helen/action-wordpress"
LABEL repository="http://github.com/helen/actions-wordpress/dotorg-plugin-deploy"

RUN apt-get update
RUN apt-get install -y subversion
RUN	apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/bin/entrypoint.sh
CMD ["entrypoint.sh"]