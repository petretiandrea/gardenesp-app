part of 'resource_cubit.dart';

@immutable
abstract class ResourceState<T> {
  bool get isLoading => this is ResourceLoading;
  bool get isSuccess => this is ResourceSuccess;
  bool get isError => this is ResourceError;
}

class ResourceInitial<T> extends ResourceState<T> {}

class ResourceLoading<T> extends ResourceState<T> {}

class ResourceError<T> extends ResourceState<T> {
  final String error;
  ResourceError(this.error);
}

class ResourceSuccess<T> extends ResourceState<T> {
  final T value;
  ResourceSuccess(this.value);
}
