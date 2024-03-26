import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gamble_card/extension.dart';
import 'package:gamble_card/jumping_mario.dart';
import 'package:gamble_card/mario.dart';
import 'package:gamble_card/mushroom.dart';
import 'package:google_fonts/google_fonts.dart';

import 'button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  double maroSize = 60;
  static double marioY = 1;
  static double shroomX = 0.5;
  static double shroomY = 1;
  double time = 0;
  double height = 0;
  double initalHeight = marioY;
  String direction = 'right';
  bool midRun = false;
  bool midJump = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, fontSize: 20));

  void ateMushroom() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      setState(() {
        // if eaten mushroom disapppear
        shroomX = 2;
        maroSize = 100;
      });
    }
  }

  void preJump() {
    time = 0;
    initalHeight = marioY;
  }

  void jump() {
    // this first if statement disable double jump
    if (midJump == false) {
      midJump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if (initalHeight - height > 1) {
          midJump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initalHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = 'right';
    ateMushroom();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      ateMushroom();
      if (MyButton(
                function: () {},
              ).userIsHoldingButton() ==
              true &&
          (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = 'left';
    ateMushroom();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      ateMushroom();
      if (MyButton(
                function: () {},
              ).userIsHoldingButton() ==
              true &&
          (marioX - 0.02) > -1) {
        setState(() {
          marioX -= 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(marioX, marioY),
                    child: midJump
                        ? JumpingMario(
                            direction: direction,
                            size: maroSize,
                          )
                        : MyMario(
                            size: maroSize,
                            direction: direction,
                            midRun: midRun,
                          ),
                  ),
                ),
                Container(
                    alignment: Alignment(shroomX, shroomY),
                    child: const Mushroom()),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('MARIO', style: gameFont),
                          10.0.verticalSpacer,
                          Text('0000', style: gameFont)
                        ],
                      ),
                      Column(
                        children: [
                          Text('WORLD', style: gameFont),
                          10.0.verticalSpacer,
                          Text('1-1', style: gameFont)
                        ],
                      ),
                      Column(
                        children: [
                          Text('TIME', style: gameFont),
                          10.0.verticalSpacer,
                          Text('9999', style: gameFont),
                        ],
                      )
                    ],
                  ),
                )
              ])),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  function: moveLeft,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                MyButton(
                    function: jump,
                    child: const Icon(Icons.arrow_upward, color: Colors.white)),
                MyButton(
                  function: moveRight,
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
