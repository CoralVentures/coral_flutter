# File Structure

The counter example is our basic example using coral_flutter, and we will use it to describe the organization of our file structure.

## Counter Example

### app directory

```md
lib/
  app/
    builder.dart
    router.dart
```

`builder.dart` contains our `appBuilder`, which we can use to build our `App`.  This is used from the `lib/main/<environment>.dart` files. This is also used in our tests to ensure we are building our app the same way.

`router.dart` sets up our page routes using [auto_route](https://pub.dev/packages/auto_route).

### blocs directory

```md
lib/
  blocs/
    counter/
      event_analytic_listener.dart
      bloc.dart
      event.dart
      state.dart
    analytic_listeners.dart
    bloc_type.dart
    redux_remote_devtools.dart
```

The blocs directory contains our `counter` bloc and some other files. Let's first focus on the bloc.

The `event_analtics_listener.dart` is where we define our analytic events to be sent off to Segment (or wherever). We will switch over all of our defined eventTypes.

The `bloc.dart` defines our bloc, the `event.dart` file defines our bloc events, and the `state.dart` file defines our bloc's state.

Aside from the counter bloc files, we also have the `analytics_listeners.dart` file. This is just the aggregation of all the analytics_listener files from all of our blocs. We use this list in our appBuilder as well as in our tests.

The `bloc_type.dart` file contains an enum that includes the blocType for all of our blocs and cubits.

The `redux_remote_devtools.dart` file is how we wire up redux remote devtools to see our application state in a browser. This is really helpful if you haven't seen it before. Gone are the days where we squint over console logs to piece together our application state.

### l10n Directory

```md
lib/
  l10n/
    arb/
      app_en.arb
    l10n.dart
```

The l10n directory contains our localization files.  The `app_en.arb` is our template arb file where we define all of our fields in english. We can then make variations of this arb file to support other languages.

_Note: if you are using an editor, you can select json as the language to edit an arb file_

_Note: At the root of our directory, we also have a l10n.yaml file that helps set this up._

### main directory

```md
lib/
  main/
    configuration.dart
    development_redux_devtools.dart
    development.dart
    production.dart
```

The `configuration.dart` file is where we will define all of our secrets for each development environment.

The `development.dart`, `development_redux_devtools.dart` and `production.dart` files are where we bootstrap our application for different environments.

_Note: `.vscode/launch.json` has different builds for each of these files._

### pages directory

```md
lib/
  pages/
    home/
      widgets/
        connector/
          counter_test.dart
          decrement_button.dart
          increment_button.dart
      page.dart
```

As you can see, we have a directory for our widget connectors (`widgets/connector/`). We could also have a directory for our dumb widgets (`widgets/dumb/`), we just didn't have any in this example.

We also have the `page.dart` where we define out page and scaffold widgets.

_Note: in significantly large applications, we have also had a directory called `flows` where each flow has a `pages` directory underneath it._

### styles directory

This is in the counter example for expediency, but ideally this would not live in the application, and would instead live in an external UI Kit library.

### test directory

```md
test/
  user_stories/
    abc_1_test.dart
  flutter_test_config.dart
 gallery.css
```

All of our tests will be defined in the `user_stories` directory.

_Note: each test will be named by the story id that it is supporting._

We use mkdocs to create out gallery and the `gallery.css` file is used but our configuration `mkdocs.yml` to style the gallyer.

To view the gallery, run:

```sh
mkdocs serve
```

### tools directory

The tools directory has a few helper tools:

- `build_runner.sh`: This will run the build_runner tool, which needs to be run anytime you update code that affects json serialization.
- `check_coverage_and_open.sh`: This will check the test coverage and open a browser with the result.
- `goldens_update.sh`: This will update all of the golden images across our test suite.

### yaml files

- **analysis_options.yaml**: This file is used by the dart analysis server.
- **dart_test.yaml**: This file is used by our tests to define the golden tag.
- **l10n.yaml**: This file is used to set up our localization.
- **mkdocs.yml**: This file is used to create our gallery.
- **pubspec.yaml**: This file defines the configuration of our application.
