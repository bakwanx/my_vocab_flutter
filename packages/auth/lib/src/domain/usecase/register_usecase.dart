import 'package:auth/src/data/model/dto/register_dto.dart';
import 'package:common_dependency/common_dependency.dart';

import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  @override
  Future<Either<Exception, void>> call(RegisterDto registerDto) async {

    final service = await authRepository.register(registerDto);

    return service.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }
}
