import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/components/npc/person.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/world.dart';
import 'package:flutter/cupertino.dart';

class MyGame extends FlameGame<MyWorld>
    with SingleGameInstance, HasPerformanceTracker, HasCollisionDetection<Broadphase<ShapeHitbox>> {
  MyGame({super.world, super.camera});

  double get width => size.x;
  double get height => size.y;
  final math.Random rand = math.Random();

  final List<Vector2> path = <Vector2>[
    Vector2(10, 0),
    Vector2(10, 100),
    Vector2(100, 100),
    Vector2(100, 10),
    Vector2(200, 10),
    Vector2(200, 100),
    Vector2(300, 100),
    Vector2(300, 10),
  ];

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  void onLoad() {
    super.onLoad();
    // debugMode = kDebugMode;

    camera.viewfinder.anchor = Anchor.topLeft;

    add(PlayArea());

    add(FpsComponent());

    world.addAll(
      List<Npc>.generate(
        10,
        (int index) => Person(position: path.first..add(Vector2.all(math.Random().nextInt(5).toDouble()))),
      ),
    );

    world.add(Turret(position: (size / 2)..sub(Vector2.all(50)), strategy: TargetingStrategy.closest));
    world.add(Sniper(position: (size / 2)..add(Vector2.all(50)), strategy: TargetingStrategy.strongest));
  }
}
