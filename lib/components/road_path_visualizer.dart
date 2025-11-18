import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RoadPathVisualizer extends Component {
  final Path path;

  late final Paint _borderPaint;
  late final Paint _roadPaint;
  late final Paint _centerlinePaint;

  final bool _hasCenterline;
  final double _dashLength;
  final double _dashGap;

  final bool hasCenterline;

  final double dashLength;
  final double dashGap;

  RoadPathVisualizer({
    required this.path,
    double roadWidth = 15.0,
    Color roadColor = const Color(0xFF636363),
    double borderWidth = 3.0,
    Color borderColor = Colors.white,
    this.hasCenterline = true,
    double centerlineWidth = 1.5,
    Color centerlineColor = Colors.yellow,
    this.dashLength = 15.0,
    this.dashGap = 10.0,
  }) : _hasCenterline = hasCenterline,
       _dashLength = dashLength,
       _dashGap = dashGap {
    _borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = roadWidth + (borderWidth * 2)
      ..strokeJoin = StrokeJoin.round;
    _roadPaint = Paint()
      ..color = roadColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = roadWidth
      ..strokeJoin = StrokeJoin.round;
    _centerlinePaint = Paint()
      ..color = centerlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = centerlineWidth;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawPath(path, _borderPaint);
    canvas.drawPath(path, _roadPaint);

    if (_hasCenterline) {
      _drawDashedPath(canvas, path, _centerlinePaint);
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final PathMetrics pathMetrics = path.computeMetrics();

    for (final PathMetric metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + _dashLength), paint);
        distance += _dashLength + _dashGap;
      }
    }
  }
}
