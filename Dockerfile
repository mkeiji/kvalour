FROM node
WORKDIR app
RUN npm -g install static-server
COPY build /app
ENTRYPOINT ["/usr/local/bin/static-server", "-p", "80"]