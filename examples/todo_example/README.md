# todo_example

This example was created with the following flutter version:

```sh
$ flutter --version
Flutter 3.3.4 • channel stable • https://github.com/flutter/flutter.git
Framework • revision eb6d86ee27 (12 days ago) • 2022-10-04 22:31:45 -0700
Engine • revision c08d7d5efc
Tools • Dart 2.18.2 • DevTools 2.15.0
```

## Development

### Without redux remote devtools

Start an iOS simulator.

Click on the `Run and Debug` icon in VSCode and select `Launch Development` from the dropdown menu.

### With redux remote devtools

Start redux remote devtools:

```sh
remotedev --port 8001
```

Then go to a browser and open localhost:8001

Start an iOS simulator.

Click on the `Run and Debug` icon in VSCode and select `Launch Development (Redux Devtools)` from the dropdown menu.

## Gallery

Update the golden images:

```sh
./tools/goldens_update.sh
```

Then serve the gallery:

```sh
mkdocs serve
```
