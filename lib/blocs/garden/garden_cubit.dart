import 'package:dartz/dartz.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/model/garden.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'garden_state.dart';

T identity<T>(T x) => x;

class GardenCubit extends ResourceCubit<List<Garden>> {
  final GardenRepository gardenRepository;
  final UserRepository userRepository;

  GardenCubit(this.gardenRepository, this.userRepository) : super();

  Future<void> loadGardensOf(final String userId) async {
    print("loadGarden");
    return fetchResource(() {
      return gardenRepository.retrieveGardens(userId).then(
            (value) => left(value),
            onError: (error) => right(error.toString()),
          );
    });
  }

  Future<void> loadGardens() async {
    final isLogged = await userRepository.isLoggedIn();
    final loggedUser = await userRepository.currentUser();
    if (isLogged) {
      return await loadGardensOf(loggedUser.uid);
    } else {
      emit(ResourceError("User not logged"));
    }
  }
}
