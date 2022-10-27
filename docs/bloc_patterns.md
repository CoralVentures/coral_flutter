# Bloc Patterns

We are going to leave out bits of code, but let's talk through the important parts to develop our understanding.

## Basics: firing an event from the UI, handling the event inside a Bloc, and reacting to new state in the UI

Let's assume we have a bloc called `counter` and a page called `home`. We want to tap a button, increment the count, and have the UI react to the new state and display the updated count.

### Firing an event

To fire an "increment event" when a user taps the button, we first need to define the event. Blocs have a predictable file structure and live in the `lib/blocs` directory.  We can find the `counter_event.dart` file there.

```md
lib/
  blocs/
    counter/
      counter_analytic_listener.dart
      counter_bloc.dart
      counter_event.dart
      counter_state.dart
```

Let's open that up and define our increment event.

```dart
part of 'counter_bloc.dart';

enum CounterEvents {
  increment,
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
```

We will subclass `CounterEvent` and create a new event called `CounterEvent_Increment`.  We will also define a `CounterEvents` enum and add `incremenet` to it. We use this enum to define which type of event it is.

_Note: While we could switch off of the class type itself, we prefer using closed sets like an enum. By doing this, we can have our editor help us update other bits of code that depend on these events, such our analytic listeners or our blocs._

Now that we have defined our event, we will need to fire the event from our presentation layer. We **always** do this in a connector widget.

```md
lib/
  pages/
    home/
      widget_connectors/
        counter_text.dart
        increment_button.dart
      home_page.dart
```

We will fire the event from the `HomeC_IncrementButton`.

_Note: we are currently using the `ElevatedButton` as our dumb widget, but we could replace this with our own custom dumb widget that carries our styling._

```dart
class HomeC_IncrementButton extends StatelessWidget {
  const HomeC_IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CounterBloc>().add(CounterEvent_Increment());
      },
      child: const Text('Increment'),
    );
  }
}
```

### Handling the event inside the Bloc

Now that we have fired the `CounterEvent_Increment` event from the UI, we need to handle it inside of our `CounterBloc`.

```dart
class CounterBloc extends CoralBloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(
          const CounterState.initialState(),
          blocType: BlocType.counter.name,
          beforeOnClose: remoteReduxDevtoolsOnClose,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
        );

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    switch (event.eventType) {
      case CounterEvents.increment:
        yield CounterState(count: state.count + 1);
        break;
    }
  }
}
```

We use `mapEventToState` to listen for an event, switch over its eventType, and then yield new states.  In this instance, we are adding one to the count.

_Note: If you are familiar with Flutter Bloc, you will know that they deprecated `mapEventToState` in favor of using `on<EventName>`. We were unhappy with this change because it doesn't play nicely with switching over enums. Since we prefer using enums for our eventType, `CoralBloc` exposes the deprecated api, `mapEventToState`, and maps it correctly to `on` under the hood._

### Reacting to new state in the UI

Now that we have yielded an updated CounterState, we need to listen for the updated state in our presentation layer. This happens in our connector widgets.

```dart
class HomeC_CounterText extends StatelessWidget {
  const HomeC_CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.watch<CounterBloc>();
    final theme = Theme.of(context);

    return Text(
      'Count: ${counterBloc.state.count}',
      style: theme.textTheme.displaySmall,
    );
  }
}
```

As you can see, we are using `context.watch<CounterBloc>`. This is a shorthand for using `BlocBuilder`, which you could write like this:

```dart
class HomeC_CounterText extends StatelessWidget {
  const HomeC_CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Text(
          'Count: ${state.count}',
          style: theme.textTheme.displaySmall,
        );
      },
    );
  }
}
```

The main difference is `BlocBuilder` has an additional input called `buildWhen` so it will only rebuild the UI on a subset of state changes, whereas `context.watch<T>` will rebuild for any state change within the bloc.

_Note: you may see `context.read<T>` and wonder how it differs from `context.watch<T>`. The former does a one-time read and is meant to be used in callbacks or places outside of the widget tree. The latter will watch for state changes and rebuild the widget tree and therefore should only be used inside of your widget's build method._

## Where do I put my bloc?

Blocs usually fall into one of two categories:

1. The bloc is specific to one page or one flow.
2. The bloc is used by multiple pages or multiple flows.

_Note: we are describing a flow as a set of connected pages that a user might flow through._

### "Page-wrap-scaffold": Placing your bloc on a single page

We will use the "page-wrap-scaffold" method to add a bloc to our page. In this example, we will create an outer widget called `Home_Page` and a child widget called `Home_Scaffold`.

The important part here is that the **only** thing we are doing in the `Home_Page` is providing the bloc. This is because we do not want this widget to be subject to re-renders.  The `Home_Scaffold` will then have access to this bloc because it is above it in the widget tree.

When we navigate, we will navigate to the `Home_Page`.

```dart
class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const Home_Scaffold(),
    );
  }
}
```

### "Bloc-on-top": If multiple dependencies, place your widget high in the widget tree

For the most part, we want our blocs to be tied to a single page or a single flow, but there are exceptions.  When this happens, we want our bloc to be higher in the widget tree than any of its dependencies. A good place to put it then is at the top of our application, hence "bloc-on-top".

_See the bottom_nav_example for an example of this pattern._

Let's assume `FooBloc` is used by multiple flows.

```dart
class App extends StatelessWidget {
  const App({
    super.key,
    required this.analyticsRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: analyticsRepository,
      child: Builder(
        builder: (contextB) {
          return const BlocProvider(
            create: (contextP) => FooBloc(),
            child: MaterialApp(
              home: Home_Page(),
            ),
          );
        },
      ),
    );
  }
}
```

## "Double yield": triggering something like a snack bar

ATTENTION: See the **double_yield_example** for the source code.

To trigger a snack bar, we need `context` and that lives in our presentation layer. However, we want to record all actions that our application is taking as events. Events are handled in the business logic layer, and we do not pass context into our business logic layer. In short, we cannot fire a snack bar from our blocs directly.

Instead, we do a "double yield" of state and set up a BlocListener in the presentation layer.  The first yield will be something that lets the UI know to trigger a snack bar, and the second yield is to reset the state.

### Set Up Business Logic Layer

Let's assume we have a button, and when tapped, the user will see a snack bar with a greeting that says hello. Since this is a user action, we need to create an event for it.

```dart
part of 'greetings_bloc.dart';

enum GreetingsEvents { sayHello }

abstract class GreetingsEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const GreetingsEvent(this.eventType);

  final GreetingsEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class GreetingsEvent_SayHello extends GreetingsEvent {
  const GreetingsEvent_SayHello() : super(GreetingsEvents.sayHello);
}
```

Our bloc state looks like this:

```dart
part of 'greetings_bloc.dart';

enum GreetingsHelloStatus { idle, sayHello }

@JsonSerializable()
class GreetingsState extends Equatable {
  const GreetingsState({
    required this.helloStatus,
  });

  final GreetingsHelloStatus helloStatus;

  const GreetingsState.initialState() : helloStatus = GreetingsHelloStatus.idle;

  // coverage:ignore-start
  factory GreetingsState.fromJson(Map<String, dynamic> json) =>
      _$GreetingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$GreetingsStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [helloStatus];
}
```

We have a `helloStatus` with two states: `idle` and `sayHello`. We can use the `sayHello` status to trigger our snack bar, but after it is triggered, we want to reset the status to `idle` so we could potentially trigger a second snack bar sometime in the future.

This leads us to the "double-yield" pattern. Our bloc will fire two states back-to-back, the first with the `sayHello` status, and then one immediately following with the `idle` status.

This is what our bloc looks like:

```dart
class GreetingsBloc extends CoralBloc<GreetingsEvent, GreetingsState> {
  GreetingsBloc()
      : super(
          const GreetingsState.initialState(),
          blocType: BlocType.greetings.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<GreetingsState> mapEventToState(
    GreetingsEvent event,
  ) async* {
    switch (event.eventType) {
      case GreetingsEvents.sayHello:
        {
          // "Double yield"
          yield const GreetingsState(
              helloStatus: GreetingsHelloStatus.sayHello);
          yield const GreetingsState(helloStatus: GreetingsHelloStatus.idle);
        }
        break;
    }
  }
}
```

### Set Up Presentation Layer

```md
lib
  pages/
    home/
      widgets_connector/
        say_hello_button.dart
        say_hello_status_listener.dart
      home_page.dart
```

The `HomeC_SayHelloButton` will fire the `GreetingsEvent_SayHello`. Our GreetingsBloc will handle the event and perform a "double yield" of `GreetingsState`s. The first state will be what our `HomeC_SayHelloStatusListener` will trigger a `snack bar` off of. The second state will reset the status back to idle, so we could potentially fire another snack bar in the future.

Here is the say hello button:

```dart
class HomeC_SayHelloButton extends StatelessWidget {
  const HomeC_SayHelloButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_triggerSnackBar;
    final greetingsBloc = context.watch<GreetingsBloc>();

    return ElevatedButton(
      onPressed: () => greetingsBloc.add(const GreetingsEvent_SayHello()),
      child: Text(label),
    );
  }
}
```

And here is the listener:

```dart
class HomeC_SayHelloStatusListener extends StatelessWidget {
  const HomeC_SayHelloStatusListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GreetingsBloc, GreetingsState>(
      listenWhen: (previous, current) =>
          previous.helloStatus != current.helloStatus,
      listener: (context, state) {
        if (state.helloStatus == GreetingsHelloStatus.sayHello) {
          final label = AppLocalizations.of(context).home_helloWorld;

          ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text(label),
            ),
          );
        }
      },
      child: child,
    );
  }
}
```

_Note: we are calling `.hideCurrentSnackBar` in case the user tried to fire multiple snack bars in quick succession ... before they have a chance to disappear on their own._
