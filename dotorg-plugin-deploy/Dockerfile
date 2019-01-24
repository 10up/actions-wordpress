FROM debian:stable-slim

LABEL "com.github.actions.name"="WordPress Plugin Deploy"
LABEL "com.github.actions.description"="Deploy to the WordPress Plugin Repository"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

LABEL maintainer="Helen Hou-Sandí <helen.y.hou@gmail.com>"
LABEL version="1.0.0"
LABEL repository="http://github.com/helen/actions-wordpress"

RUN apt-get update
RUN apt-get install -y subversion
RUN	apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
