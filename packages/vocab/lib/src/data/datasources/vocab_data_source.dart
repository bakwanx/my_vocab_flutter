import 'package:common_dependency/common_dependency.dart';
import 'package:vocab/src/data/models/type_vocab_model.dart';

abstract class VocabDataSource {
  Future<List<TypeVocabModel>> getTypeVocabs();
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

}