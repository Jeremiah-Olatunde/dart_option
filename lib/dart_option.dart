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

U mapOr<T, U>(Option<T> option, U fallback, U Function(T) f) {
  return switch (option) {
    Some(value: T value) => f(value),
    None() => fallback,
  };
}

U mapOrElse<T, U>(Option<T> option, U Function() g, U Function(T) f) {
  return switch (option) {
    Some(value: T value) => f(value),
    None() => g(),
  };
}

Iterable<T> iter<T>(Option<T> option) {
  return switch (option) {
    Some(value: T value) => Iterable.generate(1, (_) => value),
    None() => Iterable.empty(),
  };
}

Option<U> and<T, U>(Option<T> optionA, Option<U> optionB) {
  return switch (optionA) {
    Some(value: T _) => optionB,
    None() => None(),
  };
}

Option<U> andThen<T, U>(Option<T> option, Option<U> Function(T) f) {
  return switch (option) {
    Some(value: T value) => f(value),
    None() => None(),
  };
}

Option<T> filter<T>(Option<T> option, bool Function(T) predicate) {
  return switch (option) {
    Some(value: T value) when predicate(value) => Some(value),
    _ => None(),
  };
}

Option<T> or<T>(Option<T> optionA, Option<T> optionB) {
  return switch (optionA) {
    Some(value: T value) => Some(value),
    None() => optionB,
  };
}

Option<T> orelse<T>(Option<T> option, Option<T> Function() f) {
  return switch (option) {
    Some(value: T value) => Some(value),
    None() => f(),
  };
}
