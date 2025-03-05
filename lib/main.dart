import 'package:flame/game.dart';
import 'package:flame_test/camera.dart';
import 'package:flame_test/game.dart';
import 'package:flame_test/world.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget<MyGame>(
      game: MyGame(world: MyWorld(), camera: MyCamera()),
      overlayBuilderMap: <String, OverlayWidgetBuilder<FlameGame<MyWorld>>>{
        'PauseMenu': (BuildContext context, FlameGame<MyWorld> game) {
          return const ColoredBox(color: Color(0xFF000000), child: Text('A pause menu'));
        },
      },
    ),
  );
}
