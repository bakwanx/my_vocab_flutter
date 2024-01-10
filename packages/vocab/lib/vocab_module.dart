import 'package:common_dependency/common_dependency.dart';
import 'package:vocab/src/data/datasources/vocab_data_source.dart';
import 'package:vocab/src/domain/repository/vocab_repository.dart';
import 'package:vocab/src/domain/usecase/vocab_usecase.dart';

import 'src/data/impl_repository/vocab_repository_impl.dart';

class VocabModule {
  Future<void> call() async {
    di.registerLazySingleton<VocabDataSource>(
            () => VocabDataSourceImpl(dio: di()));
    di.registerLazySingleton<VocabRepository>(() => VocabRepositoryImpl(
      vocabDataSource: di(),
      networkInfo: di(),
      masterSharedPreferences: di(),
    ));
    di.registerLazySingleton(() =>(VocabUseCase(
      vocabRepository: di(),
    )));
  }
}