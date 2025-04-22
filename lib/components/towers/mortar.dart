import 'dart:ui';

import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/config.dart';

class Mortar extends Tower {
  Mortar({required super.position, super.strategy = TargetingStrategy.groups})
    : super(
        fireInterval: 5,
        range: 150,
        paint:
            Paint()
              ..color = const Color(0xffff0000)
              ..style = PaintingStyle.fill,
      );

  @override
  void fire() {
    final Npc? target = getTarget();

    if (target == null) {
      return;
    }

    world.add(Bomb(position: position, target: target));
  }
}
