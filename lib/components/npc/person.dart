import 'package:flame/components.dart';
import 'package:flame_test/components/index.dart';

class Person extends Npc {
  Person() : super(position: Vector2(10, 10), health: 10);

  Person.random(Vector2 size) : super.random(size);
}
