import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/game.dart';
import 'package:flutter/material.dart';

class Npc extends CircleComponent with HasGameReference<MyGame>, CollisionCallbacks {
  double health;

  Npc({required super.position, required this.health, double radius = Config.radius})
    : super(
        radius: radius,
        anchor: Anchor.topLeft,
        paint:
            Paint()
              ..color = const Color(0xffa60827)
              ..style = PaintingStyle.fill,
        children: <Component>[CircleHitbox()],
      );

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Projectile) {
      removeFromParent();
    } else {
      debugPrint('collision with $other');
    }
  }
}
