import 'package:tower_defense/components/index.dart';

class Bomb extends Projectile {
  Bomb({required super.position, required super.target, super.speed = 150, super.damage = 3, super.splashRange = 10});
}
