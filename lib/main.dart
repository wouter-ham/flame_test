import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game.dart';
import 'package:tower_defense/screens/settings.dart';
import 'package:tower_defense/world.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget<MyGame>(
          game: MyGame(world: MyWorld()),
          overlayBuilderMap: <String, OverlayWidgetBuilder<MyGame>>{
            'SettingsMenu': (BuildContext context, MyGame game) {
              return SettingsMenu(game: game);
            },
          },
        ),
      ),
    ),
  );
}
