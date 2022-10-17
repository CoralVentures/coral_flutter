# Developer Set Up

## Flutter

Follow the [official instructions](https://docs.flutter.dev/get-started/install/macos) to download flutter.

## Mkdocs

To install [mkdocs](https://www.mkdocs.org/) run:

```sh
brew install mkdocs
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
