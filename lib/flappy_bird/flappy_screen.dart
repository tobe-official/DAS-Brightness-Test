import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/flappy_bird/barrier.dart';
import 'package:ip_sprint_brightness/flappy_bird/bird.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class FlappyScreen extends StatefulWidget {
  const FlappyScreen({super.key});

  @override
  State<FlappyScreen> createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyScreen> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  bool gameHasStarted = false;
  Timer? gameTimer;
  double velocity = 0.015;
  int score = 0;

  final Random rand = Random();
  List<Map<String, dynamic>> barriers = [];

  List<double> generateRandomBarrierHeights() {
    double top = rand.nextDouble() * 200 + 50;
    double bottom = 300 - top;
    return [top, bottom];
  }

  void startGame() {
    gameHasStarted = true;
    time = 0;
    initialPos = 0;

    int initialBarrierCount = rand.nextInt(3) + 2;
    barriers = List.generate(initialBarrierCount, (index) {
      return {
        'x': 1.0 + index * 1.0,
        'heights': generateRandomBarrierHeights(),
        'passed': false,
      };
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      velocity += 0.00005;

      if (mounted) {
        setState(() {
          birdY = initialPos - height;
          for (var barrier in barriers) {
            barrier['x'] -= velocity;
          }
        });
      }

      if (birdY > 1 || birdY < -1) {
        timer.cancel();
        gameTimer?.cancel();
        resetGame();
      }

      Size screenSize = MediaQuery.of(context).size;

      for (var barrier in barriers) {
        double x = barrier['x'];
        List<double> heights = barrier['heights'];
        double gapTop = -1 + 2 * (heights[0] / screenSize.height);
        double gapBottom = 1 - 2 * (heights[1] / screenSize.height);

        if ((x).abs() < 0.1 && (birdY < gapTop + 0.02 || birdY > gapBottom - 0.02)) {
          timer.cancel();
          gameTimer?.cancel();
          resetGame();
        }

        if (!barrier['passed'] && x < 0 && x > -0.1) {
          score++;
          barrier['passed'] = true;
        }
      }

      if (barriers.isNotEmpty && barriers.first['x'] < -1.5) {
        barriers.removeAt(0);
        barriers.add({
          'x': barriers.last['x'] + rand.nextDouble() * 1.5 + 0.8,
          'heights': generateRandomBarrierHeights(),
          'passed': false,
        });
      }
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void resetGame() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Oops, you lost the game!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Flappy Train',
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdY),
                    duration: const Duration(milliseconds: 0),
                    color: SBBColors.charcoal,
                    child: const Bird(),
                  ),
                  ...barriers.expand((barrier) => [
                        Barrier(
                          xPos: barrier['x'],
                          height: barrier['heights'][0],
                          isBottom: false,
                        ),
                        Barrier(
                          xPos: barrier['x'],
                          height: barrier['heights'][1],
                          isBottom: true,
                        ),
                      ]),
                  Container(
                    alignment: const Alignment(0, -0.9),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: SBBColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: SBBColors.red,
                child: Center(
                  child: Text(
                    'Pass as many doors as possible!',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: SBBFontFamily.sbbFontBold,
                      color: SBBColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    birdY = 0;
    super.dispose();
  }
}
