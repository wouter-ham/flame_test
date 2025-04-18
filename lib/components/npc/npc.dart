import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/config.dart';
import 'package:tower_defense/game.dart';
import 'package:tower_defense/misc/index.dart';

abstract class Npc extends SpriteComponent with HasGameReference<MyGame>, CollisionCallbacks {
  late final TravelType travelType;
  double health = 10;
  double speed = 10;

  late final MoveAlongPathEffect moveEffect;

  Npc({required super.position, required this.health, required this.speed, required this.travelType})
    : super(
        anchor: Anchor.center,
        paint:
            Paint()
              ..color = const Color(0xffa60827)
              ..style = PaintingStyle.fill,
        children: <Component>[CircleHitbox()],
      );

  double get progress {
    return moveEffect.controller.progress;
  }

  @override
  Future<void> onLoad() async {
    final ui.Image image = await Flame.images.load('person.png');

    final double aspectRatio = image.height / image.width;

    size = Vector2(20, 20 * aspectRatio);
    sprite = Sprite(image);
    nativeAngle = math.pi / 2;

    moveEffect = MoveAlongPathEffect(
      game.path,
      EffectController(duration: game.pathLength / 100 * (100 / speed)),
      absolute: true,
      oriented: true,
      onComplete: removeFromParent,
    );

    add(moveEffect);

    return super.onLoad();
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    await moveEffect.mounted;

    if (!moveEffect.isMounted || moveEffect.controller.completed) {
      removeFromParent();
      return;
    }

    moveEffect.controller.advance(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Projectile) {
      health -= other.damage;
      if (health < 0) {
        removeFromParent();
      }
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
                to: Vector2(
                  (math.Random().nextDouble() - .5) * Config.particleDistance,
                  (math.Random().nextDouble() - .5) * Config.particleDistance,
                ),
                child: FadeOutParticle(radius: 2, paint: Paint()..color = Colors.red),
                curve: Curves.easeOut,
                lifespan: .2,
              ),
        ),
      ),
    );
  }
}
