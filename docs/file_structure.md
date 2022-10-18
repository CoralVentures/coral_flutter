# File Structure

The counter example is our basic example using coral_flutter, and we will use it to describe the organization of our file structure.

## Counter Example

### app directory

```md
lib/
  app/
    app_builder.dart
    app_router.dart
```

The app directory contains our `appBuilder`, which we can use to build our `App`.  This is used from the `lib/main/main_x.dart` files. This is also used in our tests to ensure we are building our app the same way.

### blocs directory

```md
lib/
  blocs/
    counter/
      counter_analytic_listener.dart
      counter_bloc.dart
      counter_event.dart
      counter_state.dart
    analytic_listeners.dart
    bloc_type.dart
    redux_remote_devtools.dart
```

The blocs directory contains our `counter` bloc and some other files. Let's first focus on the bloc.

The `counter_analtics_listener.dart` is where we define our analytic events to be send off to Segment (or wherever). We will switch over all of our defined eventTypes.

The `counter_bloc.dart` defines our bloc, the `counter_event.dart` file defines our events, and the `counter_state.dart` file defines our state.

Aside from the counter bloc files, we also have the `analytics_listeners.dart` file. This is just the aggregation of all the analytics_listener files from all of our blocs. We use this list in our appBuilder as well as in our tests.

The `bloc_type.dart` file contains an enum that includes the blocType for all of our blocs and cubits.

The `redux_remote_devtools.dart` file is how we wire up redux remote devtools to see our application state in a browser. This is really helpful if you haven't seen it before. Gone are the days where we rely on console logs to recreate our state.

### l10n Directory

```md
lib/
  l10n/
    arb/
      app_en.arb
    l10n.dart
```

The l10n directory contains our localization files.  The `app_en.arb` is our template arb file where we define all of our fields in english. We can then make variations of this arb file to support other languages.

_Note: if you are using an editor, you can select json as the language to edit arb file_

_Note: At the root of our directory, we also have a l10n.yaml file that helps set this up._

### main directory

```md
lib/
  main/
    main_configuration.dart
    main_development_redux_devtools.dart
    main_development.dart
    main_production.dart
```

The `main_configuration.dart` file is where we will define all of our secrets for each development environment.

_Note: Since client-side secrets are generally never safe, we have traditionally checked them in to improve the developer experience. However, if we wish to use environment variables, we have established patterns using environment_config._

The `main_development.dart`, `main_development_redux_devtools.dart` and `main_production.dart` files are where we bootstrap our application for different environments.

_Note: the `.vscode/launch.json` has different builds for each of these files.

### pages directory

```md
lib/
  pages/
    home/
      widget_connectors/
        counter_test.dart
        decrement_button.dart
        increment_button.dart
      home_page.dart
```

As you can see, we have a directory for our widget connectors (`widget_connectors`). We could also have a directory for our dumb widgets (`widgets_dumb`), we just didn't have any in this example.

We also have the `home_page.dart` where we define out page and scaffold widgets.

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

We also have a `gallery.css` which is used by the root-level `mkdocs.yml` which is how we create our gallery.

Run the following to view the gallery:

```sh
mkdocs serve
```

### tools directory

The tools directory has a few helper tools:

- `build_runner.sh`: This will run the build_runner tool, which needs to be run anytime you update code that affects json serialization.
- `check_coverage_and_open.sh`: This will check the test coverage and open a browser with the result.
- `goldens_update.sh`: This will update all of the golden images across our test suite.

### yaml files

- **analysis_options.yaml**: This file is used by the dart analysis serve.
- **dart_test.yaml**: This file is used by our tests to define the golden tag.
- **l10n.yaml**: This file is used to set up our localization.
- **mkdocs.yml**: This file is used to create our gallery.
- **pubspec.yaml**: This file defines the configuration of our application.
