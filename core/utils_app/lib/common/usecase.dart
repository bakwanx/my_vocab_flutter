import 'package:common_dependency/common_dependency.dart';

abstract class UseCase<Unit> {
  Future<Either<Exception, dynamic>> call(Map<String, dynamic> data,
      {Map<String, dynamic>? option});
}

