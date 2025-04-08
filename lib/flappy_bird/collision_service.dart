import 'package:flutter/material.dart';
import 'game_collider.dart';
import 'barrier_model.dart';

class CollisionService {
  static bool checkCollision({
    required GameCollider bird,
    required List<BarrierModel> barriers,
    required Size screenSize,
  }) {
    for (var barrier in barriers) {
      double x = barrier.x;
      List<double> heights = barrier.heights;
      double offset = barrier.offset;
      double barrierWidth = 55;
      double barrierXPos = (x + 1) / 2 * screenSize.width;

      final topCollider = GameCollider(
        center: Offset(barrierXPos + barrierWidth / 2, heights[0] / 2 + offset),
        size: barrierWidth,
        height: heights[0],
      );

      final bottomCollider = GameCollider(
        center: Offset(barrierXPos + barrierWidth / 2, screenSize.height - heights[1] / 2 + offset),
        size: barrierWidth,
        height: heights[1],
      );

      if (bird.collidesWith(topCollider) || bird.collidesWith(bottomCollider)) {
        return true;
      }
    }
    return false;
  }
}
