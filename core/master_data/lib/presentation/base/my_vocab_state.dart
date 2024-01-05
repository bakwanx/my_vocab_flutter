import 'package:common_dependency/common_dependency.dart';

abstract class MyVocabState{
  Exception? get errorState;
  bool? get isLoading;
  @override
  bool operator == (Object other){
    return other is MyVocabState &&
        other.errorState == errorState && other.isLoading == isLoading;
  }

  @override
  int get hashCode {
    return errorState.hashCode ^ isLoading.hashCode;
  }

}