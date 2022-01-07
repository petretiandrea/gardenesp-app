import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'resource_state.dart';

typedef FetchFunction<S> = Future<Either<S, String>> Function();

abstract class ResourceCubit<S> extends Cubit<ResourceState<S>> {
  ResourceCubit() : super(ResourceInitial<S>());

  void fetchResource(FetchFunction<S> fetch) async {
    try {
      emit(ResourceLoading(null));
      final result = await fetch();
      final newState = result.fold<ResourceState<S>>(
          (l) => ResourceSuccess<S>(l), (r) => ResourceError<S>(r));
      emit(newState);
    } catch (error) {
      emit(ResourceError<S>(error.toString()));
    }
  }
}
