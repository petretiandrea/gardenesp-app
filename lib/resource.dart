import 'package:flutter/cupertino.dart';

@immutable
abstract class Resource<T> {}

@immutable
class LoadingResource<T> implements Resource<T> {
  final T? value;
  const LoadingResource(this.value);
}

@immutable
class FailedResource<T> implements Resource<T> {
  final String errorMessage;
  final Exception? cause;
  const FailedResource(this.errorMessage, {this.cause});
}

@immutable
class SuccessResource<T> implements Resource<T> {
  final T value;
  const SuccessResource(this.value);
}
