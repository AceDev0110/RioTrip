// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data/author.dart';
import '../data/library.dart';
import '../widgets/author_list.dart';

class AlphabetScreen extends StatelessWidget {
  final String title;
  final ValueChanged<Author> onTap;

  const AlphabetScreen({
    required this.onTap,
    this.title = 'Alphabet',
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AuthorList(
          authors: libraryInstance.allAlphabet,
          onTap: onTap,
        ),
      );
}
