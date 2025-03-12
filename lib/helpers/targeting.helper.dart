import 'package:flame_test/components/npc/npc.dart';
import 'package:flame_test/components/towers/tower.dart';
import 'package:flame_test/config.dart';

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

  static Npc? findFastest(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs)..sort((Npc a, Npc b) => b.speed.compareTo(a.speed));

    return npcsInRange.isEmpty ? null : npcsInRange.first;
  }

  static Npc? findFurthestOnPath(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs)
      ..sort((Npc a, Npc b) => (b.progress ?? 1).compareTo(a.progress ?? 1));

    npcs.forEach((Npc npc) {
      print('${npc.travelType} ${npc.progress}');
    });

    return npcsInRange.isEmpty ? null : npcsInRange.first;
  }

  static Npc? findWithFlyingPreference(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs);
    final List<Npc> flying =
        npcsInRange.where((Npc npc) => npc.travelType == TravelType.flying).toList()
          ..sort((Npc a, Npc b) => b.speed.compareTo(a.speed));
    final List<Npc> ground =
        npcsInRange.where((Npc npc) => npc.travelType == TravelType.ground).toList()
          ..sort((Npc a, Npc b) => b.speed.compareTo(a.speed));

    if (flying.isNotEmpty) {
      return flying.first;
    }

    return ground.isEmpty ? null : ground.first;
  }

  static Npc? findWithGroundPreference(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs);
    final List<Npc> flying =
        npcsInRange.where((Npc npc) => npc.travelType == TravelType.flying).toList()
          ..sort((Npc a, Npc b) => b.speed.compareTo(a.speed));
    final List<Npc> ground =
        npcsInRange.where((Npc npc) => npc.travelType == TravelType.ground).toList()
          ..sort((Npc a, Npc b) => b.speed.compareTo(a.speed));

    if (ground.isNotEmpty) {
      return ground.first;
    }

    return flying.isEmpty ? null : flying.first;
  }
}
