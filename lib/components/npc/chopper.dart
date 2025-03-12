import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';

class Chopper extends Npc {
  Chopper({super.position}) : super(health: 10, speed: 10, travelType: TravelType.flying);
}
