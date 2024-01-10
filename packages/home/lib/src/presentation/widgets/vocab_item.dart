import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';
import 'package:vocab/vocab.dart';

import '../../domain/entities/vocab_entity.dart';

class VocabItem extends StatelessWidget {
  final VocabEntity vocabEntity;
  final int index;

  const VocabItem({super.key, required this.index, required this.vocabEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BaseVocabScreen(
              idVocab: vocabEntity.idVocab,
            ),
          ),
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
          color: Colors.primaries[index % Colors.primaries.length].shade100,
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
