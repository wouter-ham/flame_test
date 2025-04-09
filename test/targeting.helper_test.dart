import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/components/npc/index.dart';
import 'package:tower_defense/config.dart';
import 'package:tower_defense/helpers/index.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Targeting strategy calculation', () {
    final Vector2 position = Vector2.all(100);

    final List<Npc> npcs = <Npc>[
      Person(position: Vector2(10, 10))
        ..health = 1
        ..speed = 1, // Weakest
      Person(position: Vector2(10, 30))
        ..health = 2
        ..speed = 2, // Group center
      Person(position: Vector2(10, 100))
        ..health = 3
        ..speed = 3,
      Person(position: Vector2(50, 100))
        ..health = 4
        ..speed = 5, // Fastest grounded
      Person(position: Vector2(100, 100))
        ..health = 5
        ..speed = 4, // Closest
      Chopper(position: Vector2(100, 50))
        ..health = 6
        ..speed = 6,
      Chopper(position: Vector2(200, 10))
        ..health = 7
        ..speed = 7,
      Chopper(position: Vector2(200, 100))
        ..health = 8
        ..speed = 8,
      Chopper(position: Vector2(250, 10))
        ..health = 9
        ..speed = 10, // Fastest & fastest flyer
      Chopper(position: Vector2(300, 10))
        ..health = 10
        ..speed = 9, // Strongest
    ];

    test('Filter in range', () {
      final Turret turret = Turret(position: position, strategy: TargetingStrategy.closest);

      final List<Npc> inRange = TargetingHelper.filterInRange(turret, npcs);

      expect(inRange.map((Npc npc) => npc.position), <Vector2>[
        Vector2(10, 10),
        Vector2(10, 30),
        Vector2(10, 100),
        Vector2(50, 100),
        Vector2(100, 100), // closest
        Vector2(100, 50),
        Vector2(200, 10),
        Vector2(200, 100),
        Vector2(250, 10),
      ]);
    });

    test('Closest', () {
      final Turret turret = Turret(position: position, strategy: TargetingStrategy.closest);

      final Npc? closest = TargetingHelper.findClosestNpc(turret, npcs);

      expect(closest, npcs[4]);
    });

    test('Weakest', () {
      final Sniper sniper = Sniper(position: position, strategy: TargetingStrategy.weakest);

      final Npc? weakest = TargetingHelper.findWeakest(sniper, npcs.toList());

      expect(weakest, npcs[0]);
    });

    test('Strongest', () {
      final Sniper sniper = Sniper(position: position, strategy: TargetingStrategy.strongest);

      final Npc? strongest = TargetingHelper.findStrongest(sniper, npcs.toList());

      expect(strongest, npcs[9]);
    });

    test('Fastest', () {
      final Sniper sniper = Sniper(position: position, strategy: TargetingStrategy.fastest);

      final Npc? fastest = TargetingHelper.findFastest(sniper, npcs.toList());

      expect(fastest, npcs[8]);
    });

    test('Fastest flyer', () {
      final Sniper sniper = Sniper(position: position, strategy: TargetingStrategy.flying);

      final Npc? flyer = TargetingHelper.findWithFlyingPreference(sniper, npcs.toList());

      expect(flyer, npcs[8]);
    });

    test('Fastest grounded', () {
      final Sniper sniper = Sniper(position: position, strategy: TargetingStrategy.ground);

      final Npc? grounded = TargetingHelper.findWithGroundPreference(sniper, npcs.toList());

      expect(grounded, npcs[3]);
    });

    test('Group center', () {
      final Sniper sniper = Sniper(position: position, strategy: TargetingStrategy.ground);

      final Npc? group = TargetingHelper.findGroupCenter(sniper, npcs.toList());

      expect(group, npcs[1]);
    });

    // testWithGame<MyGame>('Furthest on path', () => MyGame(world: MyWorld(), camera: MyCamera()), (MyGame game) async {
    //   final Turret turret = Turret(position: position, strategy: TargetingStrategy.furthestOnPath);
    //
    //   await game.world.add(turret);
    //   await game.world.addAll(npcs);
    //
    //   final Npc? closest = TargetingHelper.findFurthestOnPath(turret, npcs);
    //
    //   expect(closest, npcs[9]);
    // });
  });
}
