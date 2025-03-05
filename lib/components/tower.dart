import 'package:flame/components.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/helpers/targeting.helper.dart';
import 'package:flame_test/world.dart';

class Tower extends CircleComponent with HasWorldReference<MyWorld> {
  final TargetingStrategy strategy;

  Tower({required super.position, required this.strategy});

  Npc? targetNpc() {
    final Iterable<Npc> npcs = world.children.whereType<Npc>();

    return switch (strategy) {
      TargetingStrategy.closest => TargetingHelper.findClosestNpc(position, npcs.toList()),
      TargetingStrategy.strongest => TargetingHelper.findStrongest(npcs.toList()),
    };
  }

  void fire() {
    final Npc? target = targetNpc();

    if (target == null) {
      return;
    }

    add(Bullet(position: position, target: target));
  }
}
