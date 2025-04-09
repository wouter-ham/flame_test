import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/components/projectiles/projectile.dart';

class Bullet extends Projectile {
  Bullet({required super.position, required super.target, super.speed = 500, super.damage = 2});
}
