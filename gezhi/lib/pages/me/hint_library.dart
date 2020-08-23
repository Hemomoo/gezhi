import 'package:flutter/material.dart';

import 'package:gezhi/widgets/me/appbar.dart';

class HintLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Meappbar(),
      ),
    );
  }
}
