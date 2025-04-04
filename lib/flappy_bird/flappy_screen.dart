import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/flappy_bird/barrier.dart';
import 'package:ip_sprint_brightness/flappy_bird/bird.dart';
import 'package:ip_sprint_brightness/flappy_bird/game_over_screen.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_snack_bar.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class FlappyScreen extends StatefulWidget {
  const FlappyScreen({super.key});

  @override
  State<FlappyScreen> createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyScreen> {
  final int devScore = 88;
  bool snackBarBoolVelocity = false;

  // Bird position and physics
  static double birdY = 0;
  static const double birdSize = 35;
  double initialPos = birdY;
  double height = 0;
  double time = 0;

  // Game state
  bool gameHasStarted = false;
  Timer? gameTimer;
  double velocity = 0.015;
  int score = 0;

  // Barrier data
  final Random rand = Random();
  List<Map<String, dynamic>> barriers = [];

  // Generate random height for top and bottom barriers
  List<double> generateRandomBarrierHeights() {
    double top = rand.nextDouble() * 200 + 50;
    double bottom = 300 - top;
    return [top, bottom];
  }

  void startGame() {
    gameHasStarted = true;
    time = 0;
    initialPos = 0;

    // Initial barrier generation
    int initialBarrierCount = 6;
    barriers = List.generate(initialBarrierCount, (index) {
      return {
        'x': 1.0 + index * 1.0,
        'heights': generateRandomBarrierHeights(),
        'offset': 0.0,
        'movingDown': rand.nextBool(),
        'passed': false,
      };
    });

    // Start game loop
    gameTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      velocity += 0.00003 + 0.00001 * sin(score / 2);

      if (mounted) {
        setState(() {
          birdY = initialPos - height;
          for (var barrier in barriers) {
            barrier['x'] -= velocity;

            if (velocity > 0.03 && !snackBarBoolVelocity) {
              showSnackBar('Watch out! Barriers can move now', 'snackBarBoolVelocity');
            }

            // Vertical movement of barriers
            if (velocity > 0.03 && rand.nextBool()) {
              double offsetChange = 0.5;
              if (barrier['movingDown']) {
                barrier['offset'] += offsetChange;
                if (barrier['offset'] > 30) barrier['movingDown'] = false;
              } else {
                barrier['offset'] -= offsetChange;
                if (barrier['offset'] < -30) barrier['movingDown'] = true;
              }
            }
          }
        });
      }

      // Get bird hitbox
      Size screenSize = MediaQuery.of(context).size;
      double birdCenterY = (birdY + 1) * screenSize.height / 2;
      double birdTop = birdCenterY - birdSize / 2;
      double birdBottom = birdCenterY + birdSize / 2;
      double birdLeft = screenSize.width / 2 - birdSize / 2;
      double birdRight = screenSize.width / 2 + birdSize / 2;
      Rect birdRect = Rect.fromLTRB(birdLeft, birdTop, birdRight, birdBottom);

      // Bird hits ceiling or floor
      if (birdY > 1 || birdY < -1) {
        timer.cancel();
        gameTimer?.cancel();
        resetGame();
      }

      // Collision detection
      for (var barrier in barriers) {
        double x = barrier['x'];
        List<double> heights = barrier['heights'];
        double offset = barrier['offset'];
        double barrierWidth = 45;
        double barrierXPos = (x + 1) / 2 * screenSize.width;

        Rect topRect = Rect.fromLTWH(
          barrierXPos,
          0 + offset,
          barrierWidth,
          heights[0],
        );

        Rect bottomRect = Rect.fromLTWH(
          barrierXPos,
          screenSize.height - heights[1] + offset,
          barrierWidth,
          heights[1],
        );

        if (birdRect.overlaps(topRect) || birdRect.overlaps(bottomRect)) {
          timer.cancel();
          gameTimer?.cancel();
          resetGame();
        }

        // Score counting
        if (!barrier['passed'] && x < 0 && x > -0.1) {
          score++;
          barrier['passed'] = true;
        }
      }

      // Recycle barriers
      if (barriers.isNotEmpty && barriers.first['x'] < -1.5) {
        barriers.removeAt(0);
        barriers.add({
          'x': barriers.last['x'] + rand.nextDouble() * 1.5 + 0.8,
          'heights': generateRandomBarrierHeights(),
          'offset': 0.0,
          'movingDown': rand.nextBool(),
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          score: score,
          devScore: devScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Flappy Train',
        ),
        backgroundColor: SBBColors.milk,
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdY),
                    duration: const Duration(milliseconds: 0),
                    color: SBBColors.white,
                    child: const Bird(),
                  ),
                  ...barriers.expand((barrier) => [
                        Barrier(
                          xPos: barrier['x'],
                          height: barrier['heights'][0],
                          isBottom: false,
                          offset: barrier['offset'],
                        ),
                        Barrier(
                          xPos: barrier['x'],
                          height: barrier['heights'][1],
                          isBottom: true,
                          offset: barrier['offset'],
                        ),
                      ]),
                  Container(
                    alignment: const Alignment(0, -0.9),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: SBBColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: SBBColors.royal,
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

  void showSnackBar(String text, String boolToChange) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.build(
      label: text,
    ));
    switch (boolToChange) {
      case 'snackBarBoolVelocity':
        snackBarBoolVelocity = true;
        break;
      default:
        break;
    }
  }
}
