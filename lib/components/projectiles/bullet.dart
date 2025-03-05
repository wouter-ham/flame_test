import 'package:flame_test/components/index.dart';
import 'package:flame_test/components/projectiles/projectile.dart';

class Bullet extends Projectile {
  Bullet({required super.position, required super.target, super.speed = 200, super.damage = 2});
}
