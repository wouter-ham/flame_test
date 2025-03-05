import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/game.dart';
import 'package:flutter/material.dart';

class Npc extends CircleComponent with HasGameReference<MyGame> {
  double health;

  Npc({required super.position, required this.health, double radius = Config.ballRadius})
    : super(
        radius: radius,
        anchor: Anchor.topLeft,
        paint:
            Paint()
              ..color = const Color(0xffa60827)
              ..style = PaintingStyle.fill,
        children: <Component>[CircleHitbox()],
      );
}
