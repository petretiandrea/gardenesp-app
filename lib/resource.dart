abstract class Resource<T> {}

class LoadingResource<T> implements Resource<T> {}

class FailedResource<T> implements Resource<T> {
  final String errorMessage;
  final Exception? cause;
  const FailedResource(this.errorMessage, {this.cause});
}

class SuccessResource<T> implements Resource<T> {
  final T value;
  const SuccessResource(this.value);
}
