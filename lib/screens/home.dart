import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/screens/base.dart';

class HomePage extends BaseScreen {
  HomePage() : super('HOME');

  @override
  void onTapDown(TapDownEvent event) {
    game.router.pushNamed('level-selector');
  }

  @override
  void onMount() {
    super.onMount();
    add(
      TextComponent<TextPaint>(
        text: 'Tap to go to Level Selector',
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
        textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
