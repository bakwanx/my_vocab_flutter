import 'dart:io';

import 'package:auth/src/data/model/dto/register_dto.dart';
import 'package:auth/src/domain/usecase/register_usecase.dart';
import 'package:auth/src/presentation/cubit/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';

class RegisterCubit extends Cubit<RegisterState> with MyVocabListener {
  RegisterCubit({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterState.initial());

  final RegisterUseCase _registerUseCase;

  void choosePhotoProfile(ImageSource source) async {
    final permissionStatus = await CustomPermission().checkPermissionStorage();
    if (permissionStatus == false) {
      emit(
        (state).copyWith(
          exception: PermissionException(
            message: "Mohon buka permission untuk mengambil gambar",
          ),
        ),
      );
    }
    File? image = await ImagePickCrop.process(
      source: source,
      ratio: [CropAspectRatioPreset.square],
    );

    if (image != null) {
      emit((state).copyWith(photoProfile: image));
    }
  }

  Future<void> register(
    String email,
    String password,
    String fullname,
  ) async {
    emit(state.copyWith(statusLoading: true));
    if (state.photoProfile == null) {
      emit(
        (state).copyWith(
          statusLoading: false,
          exception: Exception(
            "Mohon pilih photo profile",
          ),
        ),
      );
      return;
    }

    if (email.isEmpty || password.isEmpty || fullname.isEmpty) {
      emit(
        (state).copyWith(
          statusLoading: false,
          exception: Exception(
            "Form tidak boleh kosong",
          ),
        ),
      );
      return;
    }

    String fileName = state.photoProfile!.path.split('/').last;
    final multiPartFile = await MultipartFile.fromFile(
      state.photoProfile!.path,
      filename: fileName,
    );

    final result = await _registerUseCase.call(
      RegisterDto(
        email: email,
        password: password,
        fullname: fullname,
        photoProfile: multiPartFile,
      ),
    );
    result.fold((l) {
      emit(state.copyWith(statusLoading: false, exception: l));
    }, (r) {
      emit(state.copyWith(statusRegister: true, statusLoading: false));
    });
  }

  @override
  clearErrorState() {
    emit(state.copyWith(exception: null, statusLoading: false, statusRegister: false));
  }
}
