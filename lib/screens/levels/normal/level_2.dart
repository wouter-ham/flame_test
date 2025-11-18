import 'dart:async';

import 'package:flame/components.dart';
import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/screens/levels/base_level.dart';

class Level2 extends BaseLevel {
  Level2()
    : super(
        path: <Vector2>[
          Vector2(10, 10),
          Vector2(10, 100),
          Vector2(200, 100),
          Vector2(100, 10),
          Vector2(200, 10),
          Vector2(50, 100),
          Vector2(200, 200),
          Vector2(100, 200),
          Vector2(100, 150),
          Vector2(10, 150),
        ],
      );

  @override
  void setTimeline() {
    timeline = <FutureOr<void> Function()>[
      () => Future<void>.delayed(const Duration(seconds: 3)),
      () => add(Person(position: path.first)),
      () => Future<void>.delayed(const Duration(seconds: 5)),
      () => add(Person(position: path.first)),
      () => Future<void>.delayed(const Duration(seconds: 1)),
      () => add(Person(position: path.first)),
      () => Future<void>.delayed(const Duration(seconds: 1)),
      () => add(Person(position: path.first)),
      () => Future<void>.delayed(const Duration(seconds: 1)),
      () => add(Person(position: path.first)),
    ];
  }
}
