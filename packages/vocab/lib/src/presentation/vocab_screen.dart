import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';

class VocabScreen extends StatefulWidget {
  const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  TextEditingController vocabController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  appBar() {
    return AppBar(
      title: Text(
        "Vocab",
        style: Typo.caption,
      ),
    );
  }

  Widget body() {
    Widget vocab() {
      return Container(
        child: TextFormField(
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
        ),
      );
    }

    Widget typeVocab() {
      final typeVocab = [
        'Reguler',
        'Prioritas',
        'Solitaire',
        'Debitur Modal Kerja'
      ];
      return Container(
        margin: const EdgeInsets.only(
          top: 16,
        ),
        child: DropdownButtonFormField(
          items: typeVocab
              .map(
                (dynamic item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
              .toList(),
          onSaved: (value) {
            debugPrint("pesan selected $value}");
          },
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
          onChanged: (Object? value) {},
        ),
      );
    }

    Widget note() {
      return Container(
        height: 200,
        margin: const EdgeInsets.only(
          top: 24,
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
          onChanged: (value) {
            debugPrint("pesan ${value}");
          },
        ),
      );
    }

    Widget button() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: maxWidth(context),
          child: CustomButton(
            onPressed: () {},
            textButton: "Simpan",
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: defaultMargin,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                vocab(),
                typeVocab(),
                note(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: button(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
      body: body(),
    );
  }
}
