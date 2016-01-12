# Pull base image from stock node image.
FROM node

# Maintainer
MAINTAINER Robert Schultz <hello@robertschultz.org>

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
ADD package.json /tmp/package.json
RUN cd /tmp && npm install --production --loglevel info
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/

WORKDIR /opt/app
ADD . /opt/app

# Expose the node.js port to the Docker host.
EXPOSE 3000

# This is the stock express binary to start the app.
CMD [ "bin/www" ]
