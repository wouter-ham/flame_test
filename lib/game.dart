import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/components/towers/index.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/world.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MyGame extends FlameGame<MyWorld>
    with SingleGameInstance, HasPerformanceTracker, HasCollisionDetection<Broadphase<ShapeHitbox>> {
  MyGame({super.world, super.camera});

  double get width => size.x;
  double get height => size.y;
  double get rows => size.y / Config.gridSize;
  double get cols => size.x / Config.gridSize;
  final math.Random rand = math.Random();

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  void onLoad() {
    super.onLoad();
    debugMode = kDebugMode;

    camera.viewfinder.anchor = Anchor.topLeft;

    add(PlayArea());

    add(FpsComponent());

    final Npc npc1 = Npc(position: Vector2(width * rand.nextDouble(), height * rand.nextDouble()), health: 10);
    final Npc npc2 = Npc(position: Vector2(width * rand.nextDouble(), height * rand.nextDouble()), health: 8);

    world.addAll(<Npc>[npc1, npc2]);

    world.add(Turret(position: size / 2, strategy: TargetingStrategy.closest));
  }
}
