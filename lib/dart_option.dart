sealed class Option<T> {}

class Some<T> implements Option<T> {
  final T value;
  const Some(this.value);
}

class None<T> implements Option<T> {}

bool isSome<T>(Option<T> option) {
  return switch (option) { Some(value: _) => true, None() => false };
}

bool isSomeAnd<T>(Option<T> option, bool Function(T) predicate) {
  return switch (option) {
    Some(value: T value) => predicate(value),
    None() => false,
  };
}

bool isNone<T>(Option<T> option) {
  return switch (option) {
    Some(value: _) => false,
    None() => true,
  };
}

bool isNoneOr<T>(Option<T> option, bool Function(T) predicate) {
  return switch (option) {
    Some(value: T value) => predicate(value),
    None() => true,
  };
}

T expect<T>(Option<T> option, String message) {
  return switch (option) {
    Some(value: T value) => value,
    None() => throw message,
  };
}

T unwrap<T>(Option<T> option) {
  return switch (option) {
    Some(value: T value) => value,
    None() => throw "called `unwrap` on a `None` value",
  };
}

T unwrapOr<T>(Option<T> option, T fallback) {
  return switch (option) {
    Some(value: T value) => value,
    None() => fallback,
  };
}

Option<T> inspect<T>(Option<T> option, Function(T) f) {
  switch (option) {
    case Some(value: T value):
      f(value);
    default:
  }

  return option;
}

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

Option<T> orElse<T>(Option<T> option, Option<T> Function() f) {
  return switch (option) {
    Some(value: T value) => Some(value),
    None() => f(),
  };
}

Option<T> xor<T>(Option<T> optionA, Option<T> optionB) {
  if (isSome(optionA) && isNone(optionB)) return optionA;
  if (isSome(optionB) && isNone(optionA)) return optionB;
  return None();
}

Option<T> insert<T>(Option<T> options, T value) {
  return Some(value);
}

Option<T> getOrInsert<T>(Option<T> option, T value) {
  if (isSome(option)) return option;
  return Some(value);
}

Option<T> getOrInsertWith<T>(Option<T> option, T Function() f) {
  if (isSome(option)) return option;
  return Some(f());
}

Option<T> take<T>(Option<T> option) {
  return None();
}
