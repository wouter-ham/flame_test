import 'package:flame/particles.dart';

class FadeOutParticle extends CircleParticle {
  FadeOutParticle({required super.paint, required super.radius});

  @override
  void update(double dt) {
    super.update(dt);

    final double newAlpha = (paint.color.a - 0.5 * dt).clamp(0.0, 1.0);
    paint.color = paint.color.withValues(alpha: newAlpha);
  }
}
