# Naming conventions

Rather than describing every detail of the naming convention, we will favor showing examples.

## Repository

### Naming Conventions

**Class:** AuthenticationRepository, FooBarRepository

**Folder:**

While repositories should eventually become an independent library, they may start in your application's repo. Consider this a reasonable promotion pathway:

1. repository lives in specific application repo
2. repository is promoted and becomes an independent library

For 1), the directory strucutre should look like this:

```md
lib/
  repositories/
    authentication/
      authentication_repository.dart
    foo_bar/
      foo_bar_repository.dart
```

For 2), you will need to create a new dart package. I recommend using the [very_good](https://pub.dev/packages/very_good_cli) and running a command like this:

```sh
very_good create --template=dart_pkg authentication_repository
```

## Bloc

You can use the `coral_cli` to generate a bloc for you!

Here is an example:

```sh
cd coral_cli
./bin/generate_bloc.dart ../../examples/routing_example

# Then when it asks you, enter the name of your bloc in PascalCase, but don't include the suffix `Bloc`
# E.g. Authentication, FooBar
```

### Naming Conventions

**Class**

- **Analytic Listener:** CounterEvent_AnalyticListener, FooBarEvent_AnalyticListener
- **Blocs:** CounterBloc, FooBarBloc
- **Events:** CounterEvent_Increment, FooBarEvent_Baz
- **State:** CounterState, FooBarState

**Folder**

Blocs will be placed inside of `lib/blocs/` directory and all blocs will be siblings. Reminder, use the `coral_cli` to generate your blocs.

```md
lib/
  blocs/
    analytic_listeners.dart
    bloc_type.dart
    redux_remote_devtools.dart
    counter/
      counter_analytic_listener.dart
      counter_bloc.dart
      counter_event.dart
      counter_state.dart
    foo_bar/
      foo_bar_analytic_listener.dart
      foo_bar_bloc.dart
      foo_bar_event.dart
      foo_bar_state.dart
```

### Enums

We use enums to so that our editor will yell at us if we forget to wire certain things up.

#### Bloc

All blocs will extend `CoralBloc` and pass in a `BlocType`.  The `BlocType` is an enum that will enumerate all blocs in the application layer.

```dart
// lib/blocs/bloc_type.dart

enum BlocType {
  counter,
  // CORAL_CLI_BLOC_TYPE
}
```

```dart
// lib/blocs/counter/counter_bloc.dart

class CounterBloc extends CoralBloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(
          const CounterState.initialState(),
          blocType: BlocType.counter.name, // <-- Attention
          beforeOnClose: remoteReduxDevtoolsOnClose,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
        );

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    switch (event.eventType) {
      /// ...
    }
  }
}
```

This will help us wire up:

- redux_remote_devtools.dart

#### Bloc Events

All Events will extend Equatable and define an `eventType` enum.

```dart
part of 'counter_bloc.dart';

enum CounterEvents {
  increment,
  decrement,
}

abstract class CounterEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CounterEvent(this.eventType);

  final CounterEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class CounterEvent_Increment extends CounterEvent {
  CounterEvent_Increment() : super(CounterEvents.increment);
}

class CounterEvent_Decrement extends CounterEvent {
  CounterEvent_Decrement() : super(CounterEvents.decrement);
}
```

This will help us wire up:

- mapping our bloc events to state in `counter_bloc.dart`
- mapping our bloc events to analytic events in `counter_analytic_listener.dart`

### Gotchas

You may have noticed that we are not making our events constant. This is because `very_good_analysis` has a limitation and will underreport test coverage for constant events.

```dart
abstract class CounterEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CounterEvent(this.eventType);

  /// ...
}
```

## Cubit

You can use the `coral_cli` to generate a cubit for you!

Here is an example:

```sh
cd coral_cli
./bin/generate_cubit.dart ../../examples/routing_example

# Then when it asks you, enter the name of your cubit in PascalCase, but don't include the suffix `Cubit`
# E.g. User, FooBar
```

### Naming Conventions

**Class**: UserCubit, FooBarCubit

**Folder**

Cubits will be placed inside of `lib/blocs/cubits/` directory and all cubits will be siblings. Reminder, use the `coral_cli` to generate your cubits.

### Methods should return Void

As a design choice, we are using Cubits to be the single source of truth for an entity's state.

For example, we may have a UserCubit that gets passed around between multiple Blocs.  To prevent each Bloc from accidentally keeping track of some of the UserCubit's state, we simply make all of the UserCubit method calls return `void`, and the Cubit will update its internal state instead.

## Widgets

Let's assume we have the following files.

```md
lib/
  pages/
    home/
      widgets_dumb/
        button.dart
        title.dart
      widgets_connector/
        logout_button.dart
        login_button.dart
        title.dart
      home_page.dart
```

### Naming Convention

#### Connector Widgets

The connector widgets would be named:

- HomeC_LogoutButton
- HomeC_LoginButton
- HomeC_Title

#### Dumb Widgets

The dumb widgets would be named:

- HomeC_Button
- HomeC_Title

#### Page Widgets

The Page widgets would be named:

- Home_Page
- Home_Scaffold
- Home_Body
