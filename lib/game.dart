import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/world.dart';

class MyGame extends FlameGame<MyWorld>
    with SingleGameInstance, HasPerformanceTracker, HasCollisionDetection<Broadphase<ShapeHitbox>> {
  MyGame({super.world, super.camera});

  double get width => size.x;
  double get height => size.y;
  final math.Random rand = math.Random();

  final List<Vector2> testPath = <Vector2>[
    Vector2(10, 10),
    Vector2(10, 100),
    Vector2(100, 100),
    Vector2(100, 10),
    Vector2(200, 10),
    Vector2(200, 100),
    Vector2(300, 100),
    Vector2(300, 10),
  ];

  late final Path path;
  late final double pathLength;

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  void onLoad() {
    super.onLoad();
    debugMode = kDebugMode;

    path = Path()..moveTo(testPath.first.x, testPath.first.y);

    for (int i = 1; i < testPath.length; i++) {
      final Vector2 previousPoint = testPath[i - 1];
      final Vector2 currentPoint = testPath[i];
      path.quadraticBezierTo(
        previousPoint.x,
        previousPoint.y,
        (previousPoint.x + currentPoint.x) / 2,
        (previousPoint.y + currentPoint.y) / 2,
      );
    }

    pathLength = path
        .computeMetrics()
        .map((ui.PathMetric metric) => metric.length)
        .reduce((double length, double total) => length + total);

    camera.viewfinder.anchor = Anchor.topLeft;

    add(PlayArea());
    add(FpsComponent());

    world.add(Person(position: testPath.first..add(Vector2.all(math.Random().nextInt(15).toDouble()))));
    world.add(Chopper(position: testPath.first..add(Vector2.all(math.Random().nextInt(15).toDouble()))));

    world.add(Turret(position: (size / 2)..sub(Vector2.all(50))));
    world.add(Sniper(position: (size / 2)..add(Vector2.all(50))));
    world.add(Mortar(position: (size / 2)..add(Vector2.all(100))));
  }
}
