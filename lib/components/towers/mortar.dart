import 'dart:ui';

import 'package:tower_defense/components/index.dart';

class Mortar extends Tower {
  Mortar({required super.position, super.strategy = .groups})
    : super(
        fireInterval: 5,
        range: 150,
        paint: Paint()
          ..color = const Color(0xffff0000)
          ..style = .fill,
      );

  @override
  void fire() {
    final Npc? target = getTarget();

    if (target == null) {
      return;
    }

    add(Bomb(position: position, target: target));
  }
}
