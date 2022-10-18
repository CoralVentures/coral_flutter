# Coral Cli

The **coral cli** can be found in `packages/coral_cli`. Currently it does two things:

1. Generates blocs
2. Generates cubits

Since there is a lot of boilerplate to wire up a new bloc or cubit, we built these commands to do it for you.

## Generating a bloc

```sh
cd packages/coral_cli

./bin/generate_bloc.dart ../../examples/counter_example
# When prompted, input the name of the bloc in snake_case (without the Bloc suffix)
# Examples: counter, foo_bar 
```

## Generating a cubit

```sh
cd packages/coral_cli

./bin/generate_cubit.dart ../../examples/counter_example
# When prompted, input the name of the cubit in PascalCase (without the suffics Cubit)
# Examples: Counter, FooBar
```

_TODO: need to make the api the same between blocs and cubits_
