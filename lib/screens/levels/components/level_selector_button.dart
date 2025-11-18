import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game.dart';

class LevelSelectorButton extends PositionComponent with HasGameReference<MyGame> {
  final String title;
  final String route;

  LevelSelectorButton({required this.title, required this.route});

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(
      ButtonComponent(
        button: TextComponent<TextPaint>(
          text: title,
          textRenderer: TextPaint(style: const TextStyle(color: Colors.greenAccent, fontSize: 20)),
        ),
        onPressed: () {
          game.router.pushNamed(route);
        },
      ),
    );
  }
}
