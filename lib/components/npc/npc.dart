import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/components/npc/person.dart';
import 'package:flame_test/game.dart';
import 'package:flame_test/helpers/index.dart';
import 'package:flame_test/misc/index.dart';
import 'package:flutter/material.dart';

abstract class Npc extends SpriteComponent with HasGameReference<MyGame>, CollisionCallbacks {
  late final double speed;
  double health = 10;

  Npc({required super.position, required this.health, required this.speed})
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

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final Vector2 velocity = PathfindingHelper.getVelocity(position, game.path);

    position += velocity * speed * dt;
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
