part of 'garden_editor_cubit.dart';

@immutable
class GardenEditorState {
  final String name;
  final String description;
  final FormSubmissionState formStatus;

  factory GardenEditorState.initial() => GardenEditorState(
        name: "",
        description: "",
        formStatus: FormSubmissionInitial(),
      );

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const GardenEditorState({
    required this.name,
    required this.description,
    required this.formStatus,
  });

  GardenEditorState copyWith({
    String? name,
    String? description,
    FormSubmissionState? formStatus,
  }) {
    return GardenEditorState(
      name: name ?? this.name,
      description: description ?? this.description,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  String toString() {
    return 'GardenEditorState{name: $name, description: $description, formStatus: $formStatus}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GardenEditorState &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          formStatus == other.formStatus);

  @override
  int get hashCode =>
      name.hashCode ^ description.hashCode ^ formStatus.hashCode;

  factory GardenEditorState.fromMap(Map<String, dynamic> map) {
    return new GardenEditorState(
      name: map['name'] as String,
      description: map['description'] as String,
      formStatus: map['formStatus'] as FormSubmissionState,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'description': this.description,
      'formStatus': this.formStatus,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}
