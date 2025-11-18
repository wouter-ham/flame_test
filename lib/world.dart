import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:tower_defense/game.dart';

class MyWorld extends World with HasGameReference<MyGame> {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(FpsComponent());
    add(FpsTextComponent<TextRenderer>()..priority = 999);
  }
}
