import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/src/data/models/vocab_model.dart';

abstract class HomeDataSource {
  Future<List<VocabModel>> getVocabs({required int idUser});
}

class HomeDataSourceImpl implements HomeDataSource {
  final Dio dio;


  HomeDataSourceImpl({required this.dio});

  @override
  Future<List<VocabModel>> getVocabs({required int idUser}) async {
    final params = {
      "idUser": idUser,
    };
    final response = await dio.get(urlGetVocabs, queryParameters: params);
    final vocabModels = response.data["data"]
        .map<VocabModel>(
            (data) => VocabModel.fromJson(data))
        .toList();
    return vocabModels;
  }

}