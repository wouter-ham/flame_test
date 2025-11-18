import 'dart:ui';

import 'package:tower_defense/components/index.dart';

class Sniper extends Tower {
  Sniper({required super.position, super.strategy})
    : super(
        fireInterval: 5,
        range: null,
        paint: Paint()
          ..color = const Color(0xff00d9de)
          ..style = .fill,
      );

  @override
  void fire() {
    final Npc? target = getTarget();

    if (target == null) {
      return;
    }

    add(Bullet(position: position, target: target, damage: 5));
  }
}
