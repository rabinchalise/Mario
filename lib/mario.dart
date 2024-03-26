import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  const MyMario(
      {super.key,
      required this.direction,
      required this.midRun,
      required this.size});
  final String direction;
  final bool midRun;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return SizedBox(
        height: size,
        width: size,
        child: midRun
            ? Image.asset('images/mario_run.png')
            : Image.asset('images/mario_standing.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
            height: size,
            width: size,
            child: midRun
                ? Image.asset('images/mario_run.png')
                : Image.asset('images/mario_standing.png')),
      );
    }
  }
}
