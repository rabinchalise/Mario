import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  const JumpingMario({super.key, required this.direction, required this.size});
  final double size;

  final String direction;
  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return SizedBox(
        height: size,
        width: size,
        child: Image.asset('images/mario_jumping.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          height: size,
          width: size,
          child: Image.asset('images/mario_jumping.png'),
        ),
      );
    }
  }
}
