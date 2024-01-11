import 'package:common_dependency/common_dependency.dart';
import 'dart:io';

class RegisterState implements MyVocabState {
  final Exception? exception;
  final bool statusRegister;
  final bool statusLoading;
  final File? photoProfile;

  RegisterState({
    required this.statusRegister,
    required this.statusLoading,
    required this.photoProfile,
    required this.exception,
  });

  factory RegisterState.initial() => RegisterState(
        statusRegister: false,
        statusLoading: false,
        exception: null,
        photoProfile: null,
      );

  RegisterState copyWith({
    bool? statusRegister,
    Exception? exception,
    bool? statusLoading,
    File? photoProfile,
  }) =>
      RegisterState(
          statusRegister: statusRegister ?? this.statusRegister,
          statusLoading: statusLoading ?? this.statusLoading,
          exception: exception ?? this.exception,
          photoProfile: photoProfile ?? this.photoProfile);

  @override
  Exception? get errorState => exception;

  @override
  bool? get isLoading => statusLoading;
}
