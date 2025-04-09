import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/config.dart';

class Chopper extends Npc {
  Chopper({super.position}) : super(health: 10, speed: 10, travelType: TravelType.flying);
}
