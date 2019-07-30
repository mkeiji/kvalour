FROM google/dart

WORKDIR /myapp

COPY pubspec.yaml /myapp/pubspec.yaml
COPY pubspec.lock /myapp/pubspec.lock

RUN pub get

COPY . /myapp

RUN pub get \
    && pub global activate webdev

# CMD []
ENTRYPOINT ["/root/.pub-cache/bin/webdev", "serve", "--hostname", "0.0.0.0", "web:80"]