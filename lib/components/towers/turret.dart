import 'package:flame_test/components/npc.dart';
import 'package:flame_test/components/projectiles/bullet.dart';
import 'package:flame_test/components/towers/index.dart';

class Turret extends Tower {
  Turret({required super.position, required super.strategy}) : super(fireInterval: 2);

  @override
  void fire() {
    final Npc? target = getTarget();

    if (target == null) {
      return;
    }

    world.add(Bullet(position: position, target: target));
  }
}
