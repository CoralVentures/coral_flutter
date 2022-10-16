# Routing Example

## Set up

## Prerequisites

At the top-level of coral_flutter, go to `docs/developer_set_up.md` and make sure you everything.

### Environment Variables

Copy the `.envrc.sample` to `.envrc` and replace placeholders with your Segment and Sentry secretes.

```sh
direnv allow
```

```sh
flutter pub run environment_config:generate
```

## Development

Start redux remote devtools:

```sh
remotedev --port 8001
```

Then go to a browser and open localhost:8001

Next, Click on the `Run and Debug` icon in VSCode and select `Launch Development` from the dropdown menu.

## Gallery

Update the gallery:

```sh
./tools/gallery_update.sh
```

Then serve the gallery:

```sh
mkdocs serve
```
