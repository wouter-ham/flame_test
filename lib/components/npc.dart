import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/game.dart';
import 'package:flame_test/misc/fade_out_particle.dart';
import 'package:flutter/material.dart';

class Npc extends CircleComponent with HasGameReference<MyGame>, CollisionCallbacks {
  double health = 10;

  Npc({required super.position, required this.health, double radius = Config.radius})
    : super(
        radius: radius,
        anchor: Anchor.center,
        paint:
            Paint()
              ..color = const Color(0xffa60827)
              ..style = PaintingStyle.fill,
        children: <Component>[CircleHitbox()],
      );

  Npc.random(Vector2 size)
    : super(
        radius: Config.radius,
        anchor: Anchor.center,
        paint:
            Paint()
              ..color = const Color(0xffa60827)
              ..style = PaintingStyle.fill,
        children: <Component>[CircleHitbox()],
      ) {
    position = Vector2(size.x * math.Random().nextDouble(), size.y * math.Random().nextDouble());
    health = math.Random().nextInt(10) + 1;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Projectile) {
      health -= other.damage;
      if (health < 0) {
        removeFromParent();
      }
    } else {
      debugPrint('collision with $other');
    }
  }

  @override
  void onRemove() {
    super.onRemove();

    game.world.add(
      ParticleSystemComponent(
        anchor: Anchor.topLeft,
        position: position,
        particle: Particle.generate(
          generator:
              (int i) => MovingParticle(
                to: Vector2((math.Random().nextDouble() - .5) * 20, (math.Random().nextDouble() - .5) * 20),
                child: FadeOutParticle(radius: 2, paint: Paint()..color = Colors.red),
                curve: Curves.easeOut,
                lifespan: .2,
              ),
        ),
      ),
    );
  }
}
