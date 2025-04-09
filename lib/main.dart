import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/camera.dart';
import 'package:tower_defense/game.dart';
import 'package:tower_defense/world.dart';

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
