# Developer Set Up

## Flutter

Follow the [official instructions](https://docs.flutter.dev/get-started/install/macos) to download flutter.

## Environment Variables

In the application repo, copy the `.envrc.sample` to `.envrc` and replace placeholders with the Segment and Sentry secrets.

If you do not have [direnv](https://direnv.net/), then you can install it by running:

```sh
brew install direnv
```

Then run:

```sh
direnv allow
```

Next activate [environment_config](https://pub.dev/packages/environment_config) by running:

```sh
dart pub global activate environment_config
```

Finally, generate the environment config file that will not be checked in to your version control system (i.e. make sure to add it to your .gitignore):

```sh
flutter pub run environment_config:generate 
```

## redux_remote_devtools

To run [redux_remote_devtools](https://pub.dev/packages/redux_remote_devtools), you will need to install `remotedev-server`. However, to install remotedev-server, you will need python 2 and that no longer comes stock on mac computers.

Get [pyenv](https://github.com/pyenv/pyenv):

```sh
brew install pyenv
```

Then set your shell to use python 2.7.18:

```sh
pyenv shell 2.7.18
```

Then download [remotedev-server](https://www.npmjs.com/package/remotedev-server):

```sh
npm install -g remotedev-server
```

To run the remote dev server:

```sh
remotedev --port 8001
```

Then open a browser to <a href="http://localhost:8001" target="_blank">localhost:8001</a>

## Proxyman

Install [Proxyman](https://proxyman.io/).

```sh
brew install --cask proxyman
```
