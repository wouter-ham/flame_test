import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';
import 'package:flutter/material.dart';

class Projectile extends CircleComponent with CollisionCallbacks {
  double speed;
  double damage;
  Npc target;
  TargetingStrategy strategy;

  Projectile({
    required super.position,
    required this.speed,
    required this.damage,
    required this.target,
    double radius = Config.ballRadius,
    this.strategy = TargetingStrategy.closest,
  }) : super(
         radius: radius,
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

    position += (target.position - position) * speed * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Npc) {
      removeFromParent();
    } else {
      debugPrint('collision with $other');
    }
  }
}
