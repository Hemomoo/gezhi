import 'dart:html';

import 'package:flutter/material.dart';

class Meappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [Icon(Icons.arrow_back_ios), Text('我')],
      ),
      onTap: () => {},
    );
  }
}
