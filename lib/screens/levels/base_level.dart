import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:meta/meta.dart';
import 'package:tower_defense/camera.dart';
import 'package:tower_defense/components/buttons/gear.dart';
import 'package:tower_defense/components/road_path_visualizer.dart';
import 'package:tower_defense/game.dart';

abstract class BaseLevel extends Component with HasGameReference<MyGame> {
  final List<Vector2> path;

  late final Path smoothPath;
  late final double pathLength;
  late List<FutureOr<void> Function()> timeline = <FutureOr<void> Function()>[];

  Vector2 get size => Vector2(game.width - 40, game.height - 40);

  @mustCallSuper
  BaseLevel({required this.path}) {
    smoothPath = Path()..moveTo(path.first.x, path.first.y);

    for (int i = 1; i < path.length; i++) {
      final Vector2 previousPoint = path[i - 1];
      final Vector2 currentPoint = path[i];
      smoothPath.conicTo(
        previousPoint.x,
        previousPoint.y,
        (previousPoint.x + currentPoint.x) / 2,
        (previousPoint.y + currentPoint.y) / 2,
        3,
      );
    }

    pathLength = smoothPath
        .computeMetrics()
        .map<double>((ui.PathMetric metric) => metric.length)
        .reduce((double length, double total) => length + total);

    final Rect mapBounds = smoothPath.getBounds();
    final double maxSide = math.min(mapBounds.width, mapBounds.height);
    game.camera = MyCamera.withFixedResolution(world: game.world, width: maxSide, height: maxSide);

    setup();
  }

  @mustBeOverridden
  void setTimeline();

  Future<void> setup() async {
    await loaded;

    setTimeline();

    assert(timeline.isNotEmpty);

    print(game.size);
    print(game.camera.viewport);
    print(game.camera.visibleWorldRect);

    add(
      SettingsIcon()
        ..position = Vector2(size.x - 30, 30)
        ..anchor = .topRight
        ..priority = 99,
    );

    add(RoadPathVisualizer(path: smoothPath));

    await mounted;

    for (final FutureOr<void> Function() event in timeline) {
      if (!isMounted) {
        return;
      }

      await event();
    }
  }
}
