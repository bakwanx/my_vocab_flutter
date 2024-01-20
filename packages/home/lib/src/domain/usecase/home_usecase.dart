import 'package:common_dependency/common_dependency.dart';
import 'package:home/src/domain/entities/vocab_entity.dart';
import 'package:home/src/domain/repository/home_repository.dart';

class HomeUseCase  {
  final HomeRepository homeRepository;
  HomeUseCase({required this.homeRepository});

  @override
  Future<Either<Exception, List<VocabEntity>>> call() async {
    final service = await homeRepository.getVocabs();
    return service.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }

  Future<void> logOut() async {
    await homeRepository.logOut();
  }
}