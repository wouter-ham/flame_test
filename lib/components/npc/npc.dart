import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/config.dart';
import 'package:tower_defense/helpers/asset.helper.dart';
import 'package:tower_defense/misc/index.dart';
import 'package:tower_defense/screens/levels/base_level.dart';

abstract class Npc extends PositionComponent with CollisionCallbacks {
  late SpriteSheet spriteSheet;
  final TravelType travelType;
  final String asset;
  double health = 10;
  double speed = 10;

  Vector2? _previousPosition;
  double currentAngle = math.pi / 2;

  double spriteHeight;
  double spriteWidth;

  int _currentRow = 0;

  late SpriteAnimationComponent animationComponent;

  late final MoveAlongPathEffect moveEffect;

  Npc({
    required super.position,
    required this.health,
    required this.speed,
    required this.travelType,
    this.asset = 'person.png',
    this.spriteHeight = 64,
    this.spriteWidth = 48,
  }) : super(
         anchor: .center,
         children: <Component>[CircleHitbox(anchor: .center)],
       );

  double get progress {
    return moveEffect.controller.progress;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final ui.Image image = await Flame.images.load(asset);

    final Vector2 spriteSize = Vector2(spriteWidth, spriteHeight);

    spriteSheet = SpriteSheet(image: image, srcSize: spriteSize);

    final double aspectRatio = image.height / image.width;

    size = Vector2(20, 20 * aspectRatio);
    anchor = .center;

    _currentRow = AssetHelper().getRow(currentAngle);

    final SpriteAnimation characterAnimation = spriteSheet.createAnimation(row: _currentRow, stepTime: .1);
    animationComponent = SpriteAnimationComponent(
      animation: characterAnimation,
      size: Vector2(spriteWidth, spriteHeight),
      position: position,
      anchor: .center,
    );

    add(animationComponent);

    nativeAngle = math.pi / 2;

    final BaseLevel? level = findParent<BaseLevel>();

    if (level == null) {
      return;
    }

    moveEffect = MoveAlongPathEffect(
      level.smoothPath,
      EffectController(duration: level.pathLength / 100 * (100 / speed)),
      absolute: true,
      onComplete: removeFromParent,
      // oriented: true,
    );

    add(moveEffect);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    await moveEffect.mounted;

    if (!moveEffect.isMounted || moveEffect.controller.completed) {
      removeFromParent();
      return;
    }

    if (_previousPosition != null) {
      final Vector2 displacement = position - _previousPosition!;
      if (displacement.length > 0) {
        currentAngle = displacement.screenAngle();
      }
    }
    _previousPosition = position.clone();

    final int newRow = AssetHelper().getRow(currentAngle);

    if (_currentRow != newRow) {
      final SpriteAnimation newAnimation = spriteSheet.createAnimation(row: newRow, stepTime: .1);

      animationComponent.animation = newAnimation;
      _currentRow = newRow;
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

    add(
      ParticleSystemComponent(
        anchor: .topLeft,
        position: position,
        particle: .generate(
          generator: (int i) => MovingParticle(
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
