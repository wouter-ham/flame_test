import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/game.dart';
import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent with HasGameReference<MyGame> {
  PlayArea() : super(paint: Paint()..color = const Color(0xff2f2f2f), children: <Component>[RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
  }
}
