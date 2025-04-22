import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tower_defense/components/index.dart';
import 'package:tower_defense/config.dart';
import 'package:tower_defense/helpers/targeting.helper.dart';
import 'package:tower_defense/world.dart';

abstract class Tower extends CircleComponent with HasWorldReference<MyWorld> {
  final TargetingStrategy strategy;
  final double fireInterval;
  final double? range;
  double lastFire = 0;

  Tower({
    required super.position,
    required this.fireInterval,
    required this.range,
    required super.paint,
    this.strategy = TargetingStrategy.furthestOnPath,
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
      TargetingStrategy.groups => TargetingHelper.findGroupCenter(this, npcs.toList()),
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
