import 'package:flame/components.dart';
import 'package:tower_defense/components/npc/npc.dart';
import 'package:tower_defense/components/towers/tower.dart';
import 'package:tower_defense/config.dart';

class TargetingHelper {
  static List<Npc> filterInRange(Tower tower, List<Npc> npcs) {
    if (tower.range == null) {
      return npcs;
    }
    return npcs.where((Npc npc) => tower.position.distanceTo(npc.position) <= tower.range!).toList();
  }

  static Npc? findClosestNpc(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs);

    if (npcsInRange.isEmpty) {
      return null;
    }

    Npc closest = npcsInRange.first;
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

  // Not testable because the moveEffect is not started
  static Npc? findFurthestOnPath(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs)..sort((Npc a, Npc b) {
      return b.progress.compareTo(a.progress);
    });

    return npcsInRange.isEmpty ? null : npcsInRange.first;
  }

  static Npc? findWithFlyingPreference(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs);
    final List<Npc> flying =
        npcsInRange
          ..where((Npc npc) => npc.travelType == TravelType.flying)
          ..toList()
          ..sort((Npc a, Npc b) => b.speed.compareTo(a.speed));
    final List<Npc> ground =
        npcsInRange
          ..where((Npc npc) => npc.travelType == TravelType.ground)
          ..toList()
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

  static Npc? findGroupCenter(Tower tower, List<Npc> npcs) {
    final List<Npc> npcsInRange = filterInRange(tower, npcs);

    if (npcsInRange.isEmpty) {
      return null;
    }

    final List<Vector2> positions = npcsInRange.map((Npc npc) => npc.position).toList();

    if (positions.length == 1) {
      return npcsInRange.first;
    }

    final List<List<Vector2>> groups = <List<Vector2>>[];
    final List<bool> used = List<bool>.filled(positions.length, false);

    for (int i = 0; i < positions.length; i++) {
      if (!used[i]) {
        final List<Vector2> group = <Vector2>[positions[i]];
        used[i] = true;
        for (int j = i + 1; j < positions.length; j++) {
          if (!used[j]) {
            bool inRange = false;
            for (final Vector2 posInGroup in group) {
              if (positions[j].distanceTo(posInGroup) <= Config.maxGroupBoundary) {
                inRange = true;
                break;
              }
            }
            if (inRange) {
              group.add(positions[j]);
              used[j] = true;
            }
          }
        }
        groups.add(group);
      }
    }

    // Find the largest group
    final List<Vector2> largestGroup = groups.reduce((List<Vector2> a, List<Vector2> b) => a.length > b.length ? a : b);

    // Calculate the center of the largest group
    final Vector2 groupCenter = Vector2(
      largestGroup.fold<double>(0, (double sum, Vector2 pos) => sum + pos.x) / largestGroup.length,
      largestGroup.fold<double>(0, (double sum, Vector2 pos) => sum + pos.y) / largestGroup.length,
    );

    return npcsInRange.reduce(
      (Npc a, Npc b) => (a.position.distanceTo(groupCenter) < b.position.distanceTo(groupCenter)) ? a : b,
    );
  }
}
