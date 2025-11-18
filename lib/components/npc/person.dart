import 'package:tower_defense/components/index.dart';

class Person extends Npc {
  Person({super.position}) : super(health: 10, speed: 5, travelType: .ground, asset: 'troop/walk/walk.png');
}
