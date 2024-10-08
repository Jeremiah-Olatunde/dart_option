sealed class Option<T> {}

class Some<T> implements Option<T> {
  final T value;
  const Some(this.value);
}

class None<T> implements Option<T> {}

Option<U> map<T, U>(Option<T> option, U Function(T) f) {
  return switch (option) {
    Some(value: T value) => Some(f(value)),
    None() => None(),
  };
}
