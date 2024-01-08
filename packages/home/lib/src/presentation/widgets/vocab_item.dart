import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/vocab_entity.dart';

class VocabItem extends StatelessWidget {
  final VocabEntity vocabEntity;
  const VocabItem({super.key, required this.vocabEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      height: 135,
      decoration: BoxDecoration(
        color: Colors.white,
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
          Text("data"),
          Spacer(),
          Text(
            vocabEntity.typeVocab.type,
            style: Typo.caption.copyWith(
              fontWeight: Typo.light,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
