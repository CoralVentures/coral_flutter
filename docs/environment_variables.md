# Environment Variables

Flutter doesn't have a straight forward way to support environment variables. There are several solutions to this problem, but most of them involve generating a file from environment variables, and simply not checking that file in to your version control system. We have been using [environment_config](https://pub.dev/packages/environment_config) and it does exactly that.

## environment_config

environment_config has a configuration yaml file. Since we depend on Segment and Sentry, but we don't want to check in those secrets, this is how we write our `environment_config.yaml` file:

```yaml
environment_config:
  path: environment_config.dart
  class: EnvironmentConfig

  fields:
    segment_api_write_key:
      type: String?
      env_var: 'segment_api_write_key'
    sentry_dsn:
      type: String?
      env_var: 'sentry_dsn'
```

## direnv

[direnv](https://direnv.net/) is a way to load/unload environment variables depending on which directory your shell is pointing to.

To install:

```sh
brew install direnv
```

direnv will look for a `.envrc` file and if it finds one, it will load those environment variables in to your shell.

For example, your `.envrc` file could look like this:

```sh
SEGMENT_API_WRITE_KEY=your-api-write-key
SENTRY_DSN=your-sentry-dsn
```
