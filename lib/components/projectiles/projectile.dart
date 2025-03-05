import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';
import 'package:flutter/material.dart';

abstract class Projectile extends CircleComponent with CollisionCallbacks {
  double speed;
  double damage;
  Npc target;
  TargetingStrategy strategy;

  Projectile({
    required super.position,
    required this.speed,
    required this.damage,
    required this.target,
    super.radius = Config.radius,
    this.strategy = TargetingStrategy.closest,
  }) : super(
         anchor: Anchor.center,
         paint:
             Paint()
               ..color = const Color(0xff1e6091)
               ..style = PaintingStyle.fill,
         children: <Component>[CircleHitbox()],
       );

  @override
  void update(double dt) {
    super.update(dt);

    if (target.isRemoving || target.isRemoved) {
      removeFromParent();
      return;
    }

    final Vector2 difference = target.position - position;
    final double distance = difference.length;

    final Vector2 direction = difference / distance;
    position += direction * speed * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Npc || other is SafeArea) {
      removeFromParent();
    }
  }
}
