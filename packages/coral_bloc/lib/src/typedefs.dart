typedef CoralBlocOnEvent<T> = void Function({
  required T blocType,
  required dynamic state,
  required dynamic event,
});

typedef CoralBlocOnChange<T> = CoralBlocOnEvent<T>;

typedef CoralBlocOnClose<T> = void Function({
  required T blocType,
});
