import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';

import '../models/dto/vocab_dto.dart';
import '../models/type_vocab_model.dart';
import '../models/vocab_model.dart';

abstract class VocabDataSource {
  Future<List<TypeVocabModel>> getTypeVocabs();
  Future<void> postVocab({required VocabDto vocabDto});
  Future<VocabModel> getDetailVocab({required int idVocab});
}

class VocabDataSourceImpl implements VocabDataSource {

  final Dio dio;

  VocabDataSourceImpl({required this.dio});

  @override
  Future<List<TypeVocabModel>> getTypeVocabs() async {
    final response = await dio.get(urlGetTypeVocabs);
    final typeVocabModels = response.data["data"]
        .map<TypeVocabModel>(
            (data) => TypeVocabModel.fromJson(data))
        .toList();
    return typeVocabModels;
  }

  @override
  Future<void> postVocab({required VocabDto vocabDto}) async {
    final response = await dio.post(urlPostVocab, data: vocabDto.toJson());
    if(response.statusCode == 200){
      return;
    }
    throw DioException(requestOptions: response.requestOptions, response: response);
  }

  @override
  Future<VocabModel> getDetailVocab({required int idVocab}) async {
    final params = {
      "id_vocab": idVocab,
    };
    final response = await dio.get(urlGetDetailVocab, queryParameters: params);
    return VocabModel.fromJson(response.data["data"]);
  }

}