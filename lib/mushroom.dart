import 'package:flutter/material.dart';

class Mushroom extends StatelessWidget {
  const Mushroom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35, width: 35, child: Image.asset('images/mushroom.png'));
  }
}