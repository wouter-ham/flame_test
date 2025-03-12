import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/components/npc/person.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/game.dart';
import 'package:flame_test/misc/index.dart';
import 'package:flutter/material.dart';

abstract class Npc extends SpriteComponent with HasGameReference<MyGame>, CollisionCallbacks {
  late final double speed;
  late final TravelType travelType;
  double health = 10;

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

  Npc.random(Vector2 size)
    : super(
        anchor: Anchor.center,
        paint:
            Paint()
              ..color = const Color(0xffa60827)
              ..style = PaintingStyle.fill,
        children: <Component>[CircleHitbox()],
      ) {
    position = Vector2(size.x * math.Random().nextDouble(), size.y * math.Random().nextDouble());
    health = math.Random().nextInt(10) + 1;
    speed = math.Random().nextInt(10).toDouble();
    travelType = math.Random().nextBool() ? TravelType.flying : TravelType.ground;
  }

  double? get progress {
    if (!moveEffect.isMounted) {
      return null;
    }

    return moveEffect.controller.progress;
  }

  @override
  Future<void> onLoad() async {
    final ui.Image image = await Flame.images.load('person.png');

    final double aspectRatio = image.height / image.width;

    final Vector2 size = Vector2(50, 50 * aspectRatio);

    await image.resize(size);

    print(image);

    print('image AR: $aspectRatio, $size');

    sprite = Sprite(image, srcSize: size, srcPosition: position);

    moveEffect = MoveAlongPathEffect(
      game.path,
      EffectController(duration: game.pathLength / 100 * (100 / speed)),
      absolute: true,
      oriented: true,
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
    } else if (other is! Person) {
      debugPrint('Collision with $other');
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
