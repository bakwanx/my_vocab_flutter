import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';
import 'package:vocab/vocab.dart';
import 'dart:math';
import '../../domain/entities/vocab_entity.dart';

class VocabItem extends StatelessWidget {
  final VocabEntity vocabEntity;
  final Color colorBackground;
  final BuildContext parentContext;

  const VocabItem({
    super.key,
    required this.parentContext,
    required this.colorBackground,
    required this.vocabEntity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Dialog(
              backgroundColor: colorBackground,
              insetPadding: EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 400,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              vocabEntity.vocab,
                              style: Typo.h4,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            //Name
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: maxWidth(context) * 0.3,
                                  child: Text(
                                    'Translation',
                                    style: Typo.h4.copyWith(fontSize: 14),
                                  ),
                                ),
                                Text(": "),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    vocabEntity.translation,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            //NIK
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: maxWidth(context) * 0.3,
                                  child: Text(
                                    'Type',
                                    style: Typo.h4.copyWith(fontSize: 14),
                                  ),
                                ),
                                Text(": "),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    vocabEntity.typeVocab.type,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            //Customer Type
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: maxWidth(context) * 0.3,
                                  child: Text(
                                    'Variation',
                                    style: Typo.h4.copyWith(fontSize: 14),
                                  ),
                                ),
                                Text(": "),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  vocabEntity.variation,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            //Phone Number
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: maxWidth(context) * 0.3,
                                  child: Text(
                                    'Note',
                                    style: Typo.h4.copyWith(fontSize: 14),
                                  ),
                                ),
                                Text(": "),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    vocabEntity.note,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BaseVocabScreen(
                                  idVocab: vocabEntity.idVocab,
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.app_registration)),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vocabEntity.vocab,
              style: Typo.body,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Translation : ",
                  style: Typo.h5.copyWith(fontSize: 12),
                ),
                Text(
                  vocabEntity.translation,
                  style: Typo.caption,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "Type : ",
                  style: Typo.h5.copyWith(fontSize: 12),
                ),
                Text(
                  vocabEntity.typeVocab.type,
                  style: Typo.caption,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Variation : ",
                  style: Typo.h5.copyWith(fontSize: 12),
                ),
                Text(
                  vocabEntity.variation,
                  style: Typo.caption,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
