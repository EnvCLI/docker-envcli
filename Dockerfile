############################################################
# Dockerfile
############################################################

# Set the base image
FROM docker:19.03

############################################################
# Configuration
############################################################
ENV VERSION "0.6.3"

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
    chmod +x /usr/local/bin/docker-entrypoint.sh

############################################################
# Execution
############################################################
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "envcli", "--help"]
