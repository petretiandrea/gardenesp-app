import 'package:flutter/widgets.dart';

@immutable
abstract class FormSubmissionState {}

class FormSubmissionInitial extends FormSubmissionState {}

class FormSubmissionLoading extends FormSubmissionState {}

class FormSubmissionSuccess extends FormSubmissionState {}

class FormSubmissionError extends FormSubmissionState {
  final String error;
  FormSubmissionError(this.error);
}
