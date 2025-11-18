import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game.dart';

class GearShapeComponent extends PositionComponent {
  final Paint gearPaint = Paint()..color = Colors.white;
  final int numberOfTeeth = 8;
  final double toothLength = 0.8;
  final double centerHoleRadius = 0.1;

  GearShapeComponent({required Vector2 size}) : super(size: size);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final Vector2 toothSize = Vector2(size.x * 0.1, size.x * toothLength);
    final Vector2 centerPosition = size / 2;

    for (int i = 0; i < numberOfTeeth; i++) {
      final double angle = i * (2 * pi / numberOfTeeth);

      final RectangleComponent tooth = RectangleComponent(
        size: toothSize,
        paint: gearPaint,
        anchor: .center,
        position: centerPosition + Vector2(cos(angle), sin(angle)) * (size.x / 2.5),
        angle: angle,
      );
      add(tooth);
    }
  }
}

class SettingsIcon extends PositionComponent with TapCallbacks, HasGameReference<MyGame> {
  SettingsIcon() : super(size: .all(40), priority: 99);

  @override
  Future<void> onLoad() async {
    add(
      CircleComponent(
        radius: size.x / 2,
        paint: Paint()..color = Colors.grey.shade700,
        anchor: .center,
        position: size / 2,
      ),
    );

    final GearShapeComponent gear = GearShapeComponent(size: size * 0.7);
    gear.anchor = .center;
    gear.position = size / 2;
    add(gear);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.pauseEngine();
    game.overlays.add('SettingsMenu');
  }
}
