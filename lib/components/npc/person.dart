import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';

class Person extends Npc {
  Person({super.position}) : super(health: 10, speed: 5, travelType: TravelType.ground);
}
