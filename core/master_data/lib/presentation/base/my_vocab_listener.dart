import 'package:common_dependency/common_dependency.dart';
import 'package:master_data/presentation/base/my_vocab_state.dart';

mixin MyVocabListener<STATE extends MyVocabState> on BlocBase<STATE> {
  clearErrorState();
}
