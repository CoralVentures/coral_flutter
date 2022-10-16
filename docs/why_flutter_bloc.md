# Why Flutter Bloc?

There are plenty of [state management options](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) in the Flutter ecosystem. In particular, there is visibility around:

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [flutter_redux](https://pub.dev/packages/flutter_redux)
- [getX](https://pub.dev/packages/get)
- [provider](https://pub.dev/packages/provider)
- [riverpod](https://pub.dev/packages/riverpod)

|                      | bloc | redux | getX | provider | riverpod |
|----------------------|------|-------|------|----------|----------|
| community adoption   | x    |       | x    | x        | x        |
| community excitement | x    |       |      |          | x        |
| event-driven         | x    | x     |      |          |          |
| minimal boilerplate  |      |       | x    | x        | x        |
| easy to test         | x    |       |      | x        | x        |

**The above is a subjective analysis based on our personal experiences with these libraries.*

To be explicit with our preferences:

- we believe strongly in event-driven state management. Simply being able to observe events can help aid in maintainability, testing, and analytics, which is necessary for any large project.
- we prefer using tools that have traction in the community.

**Flutter Redux**: Redux prefers a single state store and for every possible thing happening in your application to be driven by an event. This does not play nicely with Flutter because Flutter has a lot of scattered local state. You will hit cases where you are tempted to pass `context` in to your state store, and that's when you know you have gone down the rabbit hole.

Coming from a web background, we tried this state management approach first (we also tried [async_redux](https://pub.dev/packages/async_redux)) and too many hacks were necessary to make it work.

**GetX** GetX is actually heavily used, but there are a lot of critical words levied against it. Many view its architecture as an anti-pattern, that the framework does too much (like routing), and obfuscates `context` unnecessarily. From our perspective, this project has its place with beginners or potentially one-off projects. We do not view it as a viable option for seasoned flutter developers or for large projects.

**Provider** Provider has the widest adoption, especially after Google gave a nod to it early on. In our opinion, while Provider can be used for state management, it is mostly a dependency injection tool.  For example, Flutter Bloc uses Provider under the hood.  While Provider has community adoption, its author has rewritten it from the ground up and created a better alternative called Riverpod.

**Riverpod** Riverpod's adoption is growing and there is a palpable amount of excitement for this project.  If riverpod was out when Flutter Bloc was written, I am confident Flutter Bloc would depend on it instead of Provider. The main advantage of Riverpod over Provider is that you can declare shared state anywhere, and it is no longer tied to the widget tree (i.e. you don't need `context` anymore).  The main drawback of Riverpod is that it is not an event-driven architecture.

**Flutter Bloc** Flutter Bloc's adoption is comparable to Provider and is a mainstay in the flutter community. It is backed by Very Good Ventures, which is a known and respected flutter consultancy. Flutter Bloc is an event-drive state management tool and is built on top of Provider. The main drawback of Flutter Bloc is the heavy amount of boilerplate.

Given the community support, our decision really came down to Riverpod vs Flutter Bloc. We chose Flutter Bloc because we are willing to pay the boilerplate tax to get an event-driven state management tool.
