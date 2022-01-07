part of 'resource_cubit.dart';

@immutable
abstract class ResourceState<T> {
  bool get isLoading => this is ResourceLoading;
  bool get isSuccess => this is ResourceSuccess;
  bool get isError => this is ResourceError;
}

class ResourceInitial<T> extends ResourceState<T> {}

class ResourceLoading<T> extends ResourceState<T> {
  final Option<T> value;

  ResourceLoading(T? value) : this.value = value != null ? Some(value) : None();
}

class ResourceError<T> extends ResourceState<T> {
  final String error;
  ResourceError(this.error);
}

class ResourceSuccess<T> extends ResourceState<T> {
  final T value;
  ResourceSuccess(this.value);
}
