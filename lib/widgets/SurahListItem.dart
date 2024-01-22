import 'package:flutter/material.dart';

import '../core/SurahModel.dart';

class SurahListItem extends StatelessWidget {
  final Surah surah;

  const SurahListItem({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(surah.name),
      onPressed: () {
        // Navigate to Surah details
      },
    );
  }
}
