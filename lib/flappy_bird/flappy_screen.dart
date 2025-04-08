import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/flappy_bird/barrier.dart';
import 'package:ip_sprint_brightness/flappy_bird/barrier_model.dart';
import 'package:ip_sprint_brightness/flappy_bird/bird.dart';
import 'package:ip_sprint_brightness/flappy_bird/evu_bird_selection.dart';
import 'package:ip_sprint_brightness/flappy_bird/game_collider.dart';
import 'package:ip_sprint_brightness/flappy_bird/game_over_screen.dart';
import 'package:ip_sprint_brightness/flappy_bird/collision_service.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_snack_bar.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class FlappyScreen extends StatefulWidget {
  const FlappyScreen({super.key});

  @override
  State<FlappyScreen> createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyScreen> with SingleTickerProviderStateMixin {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double velocity = 0.01;

  bool gameHasStarted = false;
  bool snackBarShown = false;
  int score = 0;

  final int devScore = 88;
  final Random rand = Random();
  final List<BarrierModel> barriers = [];
  String? chosenEVU;

  late AnimationController _gameLoopController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chosenEVU == null) {
        chooseEVU();
      }
    });

    _gameLoopController = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..addListener(_updateGame);
  }

  void chooseEVU() async {
    chosenEVU = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const EvuBirdSelection(),
    );
    setState(() {});
  }

  void startGame() {
    setState(() {
      gameHasStarted = true;
      velocity = 0.01;
      score = 0;
      birdY = 0;
      initialPos = 0;
      time = 0;
      snackBarShown = false;
      barriers.clear();
      _generateBarriers();
      _gameLoopController.forward();
    });
  }

  void _updateGame() {
    _moveBird();
    _updateBarriers();
    _checkCollisionAndScore();
    _recycleBarriers();
    setState(() {});
  }

  void _moveBird() {
    time += 0.016;
    height = -2.5 * time * time + 2.0 * time;
    velocity += 0.001 * (sin(0.001) / 2);
    birdY = initialPos - height;
  }

  void _generateBarriers() {
    for (int i = 0; i < 6; i++) {
      barriers.add(BarrierModel(
        x: 1.0 + i * 1.0,
        heights: _generateRandomHeights(),
        movingDown: rand.nextBool(),
      ));
    }
  }

  List<double> _generateRandomHeights() {
    double top = rand.nextDouble() * 200 + 50;
    double bottom = 300 - top;
    return [top, bottom];
  }

  void _updateBarriers() {
    for (var barrier in barriers) {
      barrier.update(velocity, rand);
    }

    if (velocity > 0.03 && !snackBarShown) {
      showSnackBar('Watch out! Barriers can move now', 'velocityWarning');
    }
  }

  void _checkCollisionAndScore() {
    final screenSize = MediaQuery.of(context).size;
    final birdCollider = GameCollider(
      center: Offset(screenSize.width / 2 - 45, (birdY + 1) * screenSize.height / 2 - 15),
      size: 90,
      height: 30,
    );

    if (birdY > 1 ||
        birdY < -1 ||
        CollisionService.checkCollision(
          bird: birdCollider,
          barriers: barriers,
          screenSize: screenSize,
        )) {
      _gameLoopController.stop();
      resetGame();
    }

    for (var barrier in barriers) {
      if (!barrier.passed && barrier.x < 0 && barrier.x > -0.1) {
        score++;
        barrier.passed = true;
      }
    }
  }

  void _recycleBarriers() {
    if (barriers.isNotEmpty && barriers.first.x < -1.5) {
      barriers.removeAt(0);
      barriers.add(BarrierModel(
        x: barriers.last.x + rand.nextDouble() * 1.5 + 0.8,
        heights: _generateRandomHeights(),
        movingDown: rand.nextBool(),
      ));
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void resetGame() {
    birdY = 0;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(score: score, devScore: devScore),
      ),
    );
  }

  void showSnackBar(String text, String id) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.build(label: text));
    if (id == 'velocityWarning') snackBarShown = true;
  }

  @override
  void dispose() {
    _gameLoopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Flappy Train'),
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
                    child: Bird(evu: chosenEVU),
                  ),
                  ...barriers.expand((barrier) => [
                        Barrier(
                          xPos: barrier.x,
                          height: barrier.heights[0],
                          isBottom: false,
                          offset: barrier.offset,
                        ),
                        Barrier(
                          xPos: barrier.x,
                          height: barrier.heights[1],
                          isBottom: true,
                          offset: barrier.offset,
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
                    gameHasStarted ? 'Pass as many doors as possible!' : 'Tap on the screen to start the game!',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: SBBFontFamily.sbbFontBold,
                      color: SBBColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
