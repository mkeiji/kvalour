# Kvalour

## Dependencies:
1. [Dart:2.3.2-dev.0.1](https://dart.dev/)

> **NOTE**: 
> This project needs the exact Dart sdk version, otherwize it will run
> into various dependencies conflicts

## Setup
Before running the project, get the dependencies with `pub` (or `dart pub` if you haven't set it globaly)
```bash
pub get
```

## Run the app
To run the app from the command line, use [webdev](https://dart.dev/tools/webdev) to build and serve the app
```bash
webdev serve
```
Then, to view your app, use the Chrome browser to visit localhost:8080.

> **NOTE**:
> if you do not have webdev installed you can activate with:
> ```bash
> dart pub global activate webdev
> ```

## Deploy
Deploying this app in its current state is tricky for a few reasons:
- webdev server:
    - the webdev server compatible with this sdk version does not play well with
    proxies and port-forwarding, so running the app in a docker container or a 
    kubernetes cluster (or even a wsl instance) might be challenging.
<br>

- static server:
    - another option is to build the app and use its js form to be served by any
    normal webserver.
    - issue: the in-memory-service that is being used to "emulate" a back-end api
    does not work well using this method.
<br>

- suggested method:
    - to deploy this app, it is suggested that you replace the "emulated" back-end
    (in-memory-service) with a real api service, and use the built version instead
    of the webdev server.
<br>
