import 'dart:ui';

import 'package:tower_defense/components/npc/npc.dart';
import 'package:tower_defense/components/projectiles/bullet.dart';
import 'package:tower_defense/components/towers/index.dart';

class Turret extends Tower {
  Turret({required super.position, required super.strategy})
    : super(
        fireInterval: 2,
        range: 200,
        paint:
            Paint()
              ..color = const Color(0xff2da100)
              ..style = PaintingStyle.fill,
      );

  @override
  void fire() {
    final Npc? target = getTarget();

    if (target == null) {
      return;
    }

    world.add(Bullet(position: position, target: target));
  }
}
