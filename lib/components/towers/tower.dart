import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/components/index.dart';
import 'package:flame_test/config.dart';
import 'package:flame_test/helpers/targeting.helper.dart';
import 'package:flame_test/world.dart';

abstract class Tower extends CircleComponent with HasWorldReference<MyWorld> {
  final TargetingStrategy strategy;
  final double fireInterval;
  final double? range;
  double lastFire = 0;

  Tower({
    required super.position,
    required this.strategy,
    required this.fireInterval,
    required this.range,
    required super.paint,
  }) : super(radius: Config.radius, anchor: Anchor.center, children: <Component>[CircleHitbox()]);

  Npc? getTarget() {
    final Iterable<Npc> npcs = world.children.query<Npc>();

    return switch (strategy) {
      TargetingStrategy.closest => TargetingHelper.findClosestNpc(this, npcs.toList()),
      TargetingStrategy.weakest => TargetingHelper.findWeakest(this, npcs.toList()),
      TargetingStrategy.strongest => TargetingHelper.findStrongest(this, npcs.toList()),
      TargetingStrategy.fastest => TargetingHelper.findFastest(this, npcs.toList()),
      TargetingStrategy.furthestOnPath => TargetingHelper.findFurthestOnPath(this, npcs.toList()),
      TargetingStrategy.flying => TargetingHelper.findWithFlyingPreference(this, npcs.toList()),
      TargetingStrategy.ground => TargetingHelper.findWithGroundPreference(this, npcs.toList()),
      TargetingStrategy.groups => throw UnimplementedError(),
    };
  }

  @override
  void update(double dt) {
    if (lastFire < fireInterval) {
      lastFire += dt;
      return;
    }
    lastFire = 0;
    fire();
  }

  void fire();
}
