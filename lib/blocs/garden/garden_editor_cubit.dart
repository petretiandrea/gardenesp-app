import 'package:bloc/bloc.dart';
import 'package:gardenesp/blocs/login/form_submission_status.dart';
import 'package:gardenesp/model/garden.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'garden_editor_state.dart';

class GardenEditorCubit extends Cubit<GardenEditorState> {
  final GardenRepository _gardenRepository;
  final UserRepository _userRepository;

  GardenEditorCubit(
    this._gardenRepository,
    this._userRepository,
  ) : super(GardenEditorState.initial());

  void _submit(String? gardenId, String name, String description) async {
    emit(state.copyWith(formStatus: FormSubmissionLoading()));
    try {
      final userId = (await _userRepository.currentUser()).uid;
      final newGarden = Garden(
        identifier: gardenId ?? "",
        name: name,
        description: description,
        lastUpdateTime: 0,
        image: "",
      );
      await _gardenRepository.createGarden(userId, newGarden);
      emit(state.copyWith(formStatus: FormSubmissionSuccess()));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionError(error.toString())));
    }
  }

  void submitEdit(String gardenId, String name, String description) async {
    if (gardenId.isNotEmpty) {
      // TODO: make async operations
    }
  }

  void submitCreation(String name, String description) async {
    emit(state.copyWith(formStatus: FormSubmissionLoading()));
    try {
      final userId = (await _userRepository.currentUser()).uid;
      final newGarden = Garden(
        identifier: "",
        name: name,
        description: description,
        lastUpdateTime: 0, // means never
        image: "",
      );
      await _gardenRepository.createGarden(userId, newGarden);
      emit(state.copyWith(formStatus: FormSubmissionSuccess()));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionError(error.toString())));
    }
  }
}
