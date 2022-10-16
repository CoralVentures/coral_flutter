# Bloc Patterns

We are going to leave out bits of code, but let's talk through the important parts to develop our understanding.

## Basics: firing an event from the UI, handling the event inside a Bloc, and reacting to new state in the UI

Let's assume we have a bloc called `counter` and a page called `home`. We want to tap a button, increment the count, and have the UI react to the new state and display the updated count.

### Firing an event

To fire an increment event when a user taps, we first need to define the event. Blocs have a predictable file structure and live in the `lib/blocs` directory.  We can find the `counter_event.dart` file there.

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

We will subclass `CounterEvent` and create a new event called `CounterEvent_Increment`.  We will also define a `CounterEvents` enum and add `incremenet` which we will use to define which type of event this is.

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

_Note: If you are familiar with Flutter Bloc, you will know that they deprecated `mapEventToState` in favor of using `on<EventName>`. We were unhappy with this change because it doesn't play nicely with switching over enums. Since we prefer using enums for our eventType, `CoralBloc` exposes the deprecated api, `mapEventToState`, and maps it correctly to `on` under the hood._

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

### Reacting to new state in the UI

Now that we have yielded an updated CounterState, we need to listen for updates the the state in our presentation layer. This happens in our connector widgets.

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

As you can see, we are using `context.watch<CounterBloc>`. This is a shorthand for using `BlocBuilder`. An alternative way to write this is the following:

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

_Note: you may see `context.read<T>` and wonder how it differs from `context.watch<T>`. The former does a one-time read and is meant to be used in callbacks or places outside of the widget tree. The latter will watch for state changes and rebuild the widget tree and therefore should only be used inside of your build method._

## Double yield: triggering something like a snackbar

To trigger a snackbar, we need `context` and that lives in our presentation layer. However, we want to record all actions that our application is taking as events. Events are handled in the business logic layer, and we do not pass context in to our business logic layer. In short, we cannot fire a snackbar from our blocs directly.

Instead, we do a "double yield" of state and set up a BlocListener in the presentation layer.  The first yield will be something that lets the UI know to trigger a snackbar, and the second yield is to reset the state.

### Set Up Business Logic Layer

Let's assume a user is trying to login and it failed. We could show them a snackbar letting them know the login failed. Here are our events:

```dart
class AuthenticationEvent_Login extends AuthenticationEvent {
  AuthenticationEvent_Login() : super(AuthenticationEvents.login);
}

class AuthenticationEvent_LoginSucceeded extends AuthenticationEvent {
  AuthenticationEvent_LoginSucceeded() : super(AuthenticationEvents.loginSucceeded);
}

class AuthenticationEvent_LoginFailed extends AuthenticationEvent {
  AuthenticationEvent_LoginFailed() : super(AuthenticationEvents.loginFailed);
}
```

Next, lets set up our bloc:

```sh
class AuthenticationBloc
    extends CoralBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          const AuthenticationState.initialState(),
          blocType: BlocType.authentication.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event.eventType) {
      case AuthenticationEvents.login:
        yield* coralTryCatchStream<AuthenticationState>(
          tryFunc: () async* {
            yield const AuthenticationState(
              status: AuthenticationStatus.inProgress,
            );

            final _event = event as AuthenticationEvent_Login;

            final _isAuthenticated = _authenticationRepository.authenticate(
              isAuthenticated: _event.isAuthenticated,
            );

            /// Note: we are firing off events instead of setting the state
            /// directly. This is to give our analytics better visibility into
            /// what is happening.
            if (_isAuthenticated) {
              add(AuthenticationEvent_LoginSucceeded());
            } else {
              add(AuthenticationEvent_LoginFailed());
            }
          },
          catchFunc: (e, stacktrace) async* {
            add(AuthenticationEvent_LoginFailed());
          },
        );
        break;

      case AuthenticationEvents.loginSucceeded:
        yield const AuthenticationState(
          status: AuthenticationStatus.authenticated,
        );
        break;

      /// *Double Yield*
      ///
      /// Note: we are sending a status of `failed` followed by `none` because
      /// we want to hook off of the failed status, show a snack bar, and then
      /// have the status reset.
      case AuthenticationEvents.loginFailed:
        yield const AuthenticationState(
          status: AuthenticationStatus.failed,
        );

        yield const AuthenticationState(
          status: AuthenticationStatus.none,
        );
        break;
    }
  }
}
```

_Note: you may have caught the use of `coralTryCatchStream`. We use this to ensure all of our try catches inside our blocs are following the same pattern._

### Set Up Presentation Layer

```md
lib
  pages/
    login/
      widgets_connector/
        login_button.dart
        login_listener.dart
      login_page.dart
```

The `LoginC_LoginButton` will fire the `AuthenticationEvent_Login`, which will fail, and then the `AuthenticationBloc` will fire the `AuthenticationEvent_LoginFailed` event. The `AuthenticationEvent_LoginFailed` event will perform a "double yield" of `AuthenticationState`s where the first state will be what our `LoginC_LoginListener` can trigger a `Snackbar` off of.

```dart
class LoginC_LoginListener extends StatelessWidget {
  const LoginC_LoginListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.none:
          case AuthenticationStatus.inProgress:
            break; // no-op
          case AuthenticationStatus.authenticated:
            GoRouter.of(context).goNamed(AppRoutes.home.name);
            break;

          /// The first yield will have an authentication status of `failed`, and we 
          /// can use that to trigger this snackbar. The next yield will reset the 
          /// authentication status back to none.
          case AuthenticationStatus.failed:
            {
              final label = AppLocalizations.of(context).login_loginFailed;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(label),
                  backgroundColor: Colors.red,
                ),
              );
            }
            break;
        }
      },
      child: child,
    );
  }
}


```

## Where do I put my bloc?

Blocs usually fall in to one of two categories:

1. The bloc is specific to one page or one flow.
2. The bloc is used by multiple pages or multiple flows.

_Note: we are describing a flow as a set of connected pages that a user might flow through._

### Page-wrap-scaffold: Placing your bloc on a single page

We use the "page-wrap-scaffold" method to add a bloc to our page.

In this example, we create an outer widget called `Home_Page` and a child widget called `Home_Scaffold`.

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

### Bloc-on-top: Placing your widget high in the widget tree if multiple dependencies

For the most part, we want our blocs to be tied to a single page or a single flow, but there are exceptions.  When this happens, we want our bloc to be higher in the widget tree than any of the dependencies. A good place to put it then is at the top of our application.

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
