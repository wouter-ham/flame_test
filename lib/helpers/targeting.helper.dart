import 'package:flame_test/components/npc/npc.dart';
import 'package:flame_test/components/towers/tower.dart';

class TargetingHelper {
  static Npc? findClosestNpc(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs);

    if (npcsInRange.isEmpty) {
      return null;
    }
    Npc closest = npcsInRange.first;

    if (tower.range == null) {
      return closest;
    }

    double closestDistance = tower.position.distanceTo(closest.position);

    for (final Npc npc in npcsInRange) {
      final double distance = tower.position.distanceTo(npc.position);
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = npc;
      }
    }

    return closest;
  }

  static List<Npc> filterInRange(Tower tower, List<Npc> npcs) {
    if (tower.range == null) {
      return npcs;
    }
    return npcs.where((Npc npc) => tower.position.distanceTo(npc.position) <= tower.range!).toList();
  }

  static Npc? findWeakest(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs)..sort((Npc a, Npc b) => a.health.compareTo(b.health));

    return npcsInRange.isEmpty ? null : npcsInRange.first;
  }

  static Npc? findStrongest(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs)..sort((Npc a, Npc b) => b.health.compareTo(a.health));

    return npcsInRange.isEmpty ? null : npcsInRange.first;
  }
}
