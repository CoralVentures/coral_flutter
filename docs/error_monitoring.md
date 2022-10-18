# Error Monitoring

We use `coralBootstrap` in our `lib/main/main_x.dart` files. `coralBootstrap` will set up our `CoralLogger` so that any time it wants to log an error, it will send it to Sentry (or wherever we want).  In addition, `coralBootstrap` also puts up guard rails around our application, and anytime we run in to a runtime exception, it log an error.

We can also run in to exceptions in our Blocs, particularly when we are using a method from a repository. As a best practice, we wrap all of our repository method calls with either `coralTryCatch` or `coralTryCatchStream`. By default, these methods will log the error so you don't have to remember to do so.

_Note: you can see the data_layer_example for an example_
