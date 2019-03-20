############################################################
# Dockerfile
############################################################

# Set the base image
FROM docker:18.06

############################################################
# Configuration
############################################################
ENV VERSION "0.4.2"

############################################################
# Entrypoint
############################################################
COPY docker-entrypoint.sh /usr/local/bin/

############################################################
# Installation
############################################################

RUN apk add --no-cache curl bash &&\
    curl -L -o /usr/local/bin/envcli https://dl.bintray.com/envcli/golang/envcli/v${VERSION}/envcli_linux_amd64 &&\
    chmod +x /usr/local/bin/envcli &&\
    chmod +x /usr/local/bin/docker-entrypoint.sh &&\
	apk del curl

############################################################
# Execution
############################################################
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "envcli", "--help"]
