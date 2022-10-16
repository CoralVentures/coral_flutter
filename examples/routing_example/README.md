# Routing Example

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

Update the gallery:

```sh
./tools/gallery_update.sh
```

Then serve the gallery:

```sh
mkdocs serve
```
