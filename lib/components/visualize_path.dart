import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PathVisualizer extends Component {
  final Path path;
  final Paint customPaint;

  PathVisualizer({required this.path, Color color = Colors.red, double strokeWidth = 2.0, Paint? paint})
    : customPaint =
          paint ??
          (Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(path, customPaint);
  }
}
