import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/config.dart';

class Person extends Npc {
  Person({super.position}) : super(health: 10, speed: 5, travelType: TravelType.ground);
}
