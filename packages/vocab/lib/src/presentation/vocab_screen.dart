import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';
import 'package:vocab/src/domain/usecase/vocab_usecase.dart';
import 'package:vocab/src/presentation/cubit/vocab_cubit.dart';
import 'package:vocab/src/presentation/cubit/vocab_state.dart';

class BaseVocabScreen extends StatelessWidget {
  final int? idVocab;
  const BaseVocabScreen({super.key, this.idVocab});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VocabCubit(
            vocabUseCase: di<VocabUseCase>(),
            masterSharedPreferences: di<MasterSharedPreferences>(),
          ),
      child: VocabScreen(idVocab: idVocab,),
    );
  }
}

class VocabScreen extends StatefulWidget {
  final int? idVocab;
  const VocabScreen({super.key, this.idVocab});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  TextEditingController vocabController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController variationController = TextEditingController();
  TextEditingController translationController = TextEditingController();

  Future<void> initData() async {
    await context.read<VocabCubit>().getTypeVocabs();
    if(widget.idVocab != null){
      await context.read<VocabCubit>().getDetailVocab(widget.idVocab!);
    }
  }

  initUi(VocabState state) {
    if(state.detailVocabEntity != null){
      vocabController.text = state.detailVocabEntity!.vocab;
      noteController.text = state.note!;
      variationController.text = state.variation!;
      translationController.text = state.translation!;

    }

  }

  Future<void> submit() async {
    if (vocabController.text.isEmpty ||
        noteController.text.isEmpty ||
        translationController.text.isEmpty ||
        variationController.text.isEmpty) {
      context.read<VocabCubit>().setError(
        Exception("Form tidak boleh kosong"),
      );
      return;
    }
    context.read<VocabCubit>().setVocab(
      vocab: vocabController.text,
      translation: translationController.text,
      note: noteController.text,
      variation: variationController.text,
    );
    context.read<VocabCubit>().postVocab();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBar() {
      return AppBar(
        title: Text(
          "Vocab",
          style: Typo.caption,
        ),
      );
    }

    Widget body(VocabState state) {
      Widget vocab() {
        return TextFormField(
          controller: vocabController,
          keyboardType: TextInputType.text,
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: "Vocab",
            labelStyle: Typo.small.copyWith(
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        );
      }

      Widget translation() {
        return Container(
          margin: const EdgeInsets.only(
            top: 16,
          ),
          child: TextFormField(
            controller: translationController,
            keyboardType: TextInputType.text,
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: "Translation",
              labelStyle: Typo.small.copyWith(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        );
      }

      Widget typeVocab() {
        return Container(
          margin: const EdgeInsets.only(
            top: 16,
          ),
          child: DropdownButtonFormField(
            items: state.typeVocabEntities
                .map(
                  (item) =>
                  DropdownMenuItem(
                    value: item,
                    child: Text(
                      item.type,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
            )
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Harus diisi';
              }
            },
            decoration: InputDecoration(
              hintText: "Type Vocab",
              hintStyle: Typo.small,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            onChanged: (typeVocabEntity) {
              context
                  .read<VocabCubit>()
                  .setVocab(typeVocabEntity: typeVocabEntity);
            },
          ),
        );
      }

      Widget note() {
        return Container(
          height: 200,
          margin: const EdgeInsets.only(
            top: 16,
          ),
          child: TextFormField(
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            controller: noteController,
            decoration: InputDecoration(
              labelText: "Note",
              labelStyle: Typo.small.copyWith(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
          ),
        );
      }

      Widget variation() {
        return Container(
          height: 200,
          margin: const EdgeInsets.only(
            top: 16,
          ),
          child: TextFormField(
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            controller: variationController,
            decoration: InputDecoration(
              labelText: "Variation",
              labelStyle: Typo.small.copyWith(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
          ),
        );
      }

      Widget button() {
        return Container(
          width: maxWidth(context),
          margin: const EdgeInsets.only(
            top: 16,
          ),
          child: CustomButton(
            onPressed: submit,
            textButton: "Simpan",
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vocab(),
              translation(),
              typeVocab(),
              variation(),
              note(),
              button(),
            ],
          ),
        ),
      );
    }

    return MyVocabScreen<VocabCubit, VocabState>(
      child: BlocListener<VocabCubit, VocabState>(
        listener: (context, state) {
          if(state.isSuccess){
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<VocabCubit, VocabState>(
          builder: (context, state) {
            initUi(state);
            return Scaffold(
              appBar: appBar(),
              body: body(state),
            );
          },
        ),
      ),
    );
  }
}
