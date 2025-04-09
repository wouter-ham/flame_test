import 'dart:ui';

import 'package:tower_defense/components/npc/npc.dart';
import 'package:tower_defense/components/projectiles/bullet.dart';
import 'package:tower_defense/components/towers/index.dart';

class Sniper extends Tower {
  Sniper({required super.position, required super.strategy})
    : super(
        fireInterval: 5,
        range: null,
        paint:
            Paint()
              ..color = const Color(0xff00d9de)
              ..style = PaintingStyle.fill,
      );

  @override
  void fire() {
    final Npc? target = getTarget();

    if (target == null) {
      return;
    }

    world.add(Bullet(position: position, target: target, damage: 5));
  }
}
