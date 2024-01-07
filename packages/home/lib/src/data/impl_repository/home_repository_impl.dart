import 'package:common_dependency/common_dependency.dart';
import 'package:dartz/dartz.dart';
import 'package:home/src/data/datasources/home_data_source.dart';
import 'package:home/src/domain/entities/vocab_entity.dart';
import 'package:home/src/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeDataSource homeDataSource;
  final MasterSharedPreferences masterSharedPreferences;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeDataSource,
    required this.masterSharedPreferences,
  });

  @override
  Future<Either<Exception, List<VocabEntity>>> getVocabs() async {
    if (await networkInfo.isConnected) {
      try {
        int userId = 0;
        final userLocalModel = await masterSharedPreferences.getUserLocalModel();
        userId = userLocalModel.idUser;
        final result = await homeDataSource.getVocabs(userId: userId);

        return Right(result);
      } on DioException catch (error) {
        return Left(DioException(
          requestOptions: error.requestOptions,
          message: error.message,
        ));
      } catch (error) {
        return Left(Exception("Something when wrong"));
      }
    } else {
      return Left(NetworkException(message: "No Connection"));
    }
  }

}