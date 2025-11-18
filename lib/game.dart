import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide OverlayRoute, Route;
import 'package:tower_defense/camera.dart';
import 'package:tower_defense/screens/index.dart';
import 'package:tower_defense/world.dart';

class MyGame extends FlameGame<MyWorld>
    with SingleGameInstance, HasPerformanceTracker, HasCollisionDetection<Broadphase<ShapeHitbox>> {
  MyGame({super.world});

  double get width => size.x;
  double get height => size.y;

  final TextStyle style = TextStyle(color: BasicPalette.white.color, fontSize: 32, fontWeight: .bold);

  late final RouterComponent router;

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  void onLoad() {
    super.onLoad();

    camera = MyCamera();

    add(
      router = RouterComponent(
        initialRoute: 'home',
        routes: <String, Route>{
          'home': Route(HomePage.new),
          'level-selector': Route(LevelSelectorScreen.new),
          'level-1': Route(Level1.new),
          'level-2': Route(Level2.new),
        },
      ),
    );

    // debugMode = kDebugMode;
  }
}
