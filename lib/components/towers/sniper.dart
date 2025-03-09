import 'dart:ui';

import 'package:flame_test/components/npc/npc.dart';
import 'package:flame_test/components/projectiles/bullet.dart';
import 'package:flame_test/components/towers/index.dart';

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
