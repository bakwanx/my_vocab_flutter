import 'package:common_dependency/common_dependency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:vocab/src/data/datasources/vocab_data_source.dart';
import 'package:vocab/src/data/models/dto/vocab_dto.dart';
import 'package:vocab/src/domain/entity/type_vocab_entity.dart';
import 'package:vocab/src/domain/entity/vocab_entity.dart';
import 'package:vocab/src/domain/repository/vocab_repository.dart';

class VocabRepositoryImpl implements VocabRepository {

  final NetworkInfo networkInfo;
  final VocabDataSource vocabDataSource;
  final MasterSharedPreferences masterSharedPreferences;

  VocabRepositoryImpl({
    required this.networkInfo,
    required this.vocabDataSource,
    required this.masterSharedPreferences,
  });

  @override
  Future<Either<Exception, List<TypeVocabEntity>>> getTypeVocabs() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await vocabDataSource.getTypeVocabs();
        return Right(result);
      } on DioException catch (error) {
        return Left(DioException(
          requestOptions: error.requestOptions,
          message: error.message,
        ));
      } catch (error) {
        return Left(Exception(error.toString()));
      }
    } else {
      return Left(NetworkException(message: "No Connection"));
    }
  }

  @override
  Future<Either<Exception, void>> postVocab({required VocabDto vocabDto}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await vocabDataSource.postVocab(vocabDto: vocabDto);
        return Right(result);
      } on DioException catch (error) {
        return Left(DioException(
          requestOptions: error.requestOptions,
          message: error.message,
        ));
      } catch (error) {
        return Left(Exception(error.toString()));
      }
    } else {
      return Left(NetworkException(message: "No Connection"));
    }
  }

  @override
  Future<Either<Exception, VocabEntity>> getDetailVocab({required int idVocab}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await vocabDataSource.getDetailVocab(idVocab: idVocab);
        return Right(result);
      } on DioException catch (error) {
        return Left(DioException(
          requestOptions: error.requestOptions,
          message: error.message,
        ));
      } catch (error) {

        return Left(Exception(error.toString()));
      }
    } else {
      return Left(NetworkException(message: "No Connection"));
    }
  }


}