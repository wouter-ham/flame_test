import 'package:flame/components.dart';
import 'package:flame_test/components/npc.dart';

class TargetingHelper {
  // TODO add range
  static Npc? findClosestNpc(Vector2 origin, List<Npc> npcs) {
    if (npcs.isEmpty) {
      return null;
    }
    Npc closest = npcs.first;
    double closestDistance = origin.distanceTo(closest.position);

    for (final Npc npc in npcs) {
      final double distance = origin.distanceTo(npc.position);
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = npc;
      }
    }
    return closest;
  }

  // TODO add range
  static Npc findStrongest(List<Npc> npcs) {
    return (npcs..sort((Npc a, Npc b) => a.health.compareTo(b.health))).first;
  }
}
