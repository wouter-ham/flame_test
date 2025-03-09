import 'package:flame/components.dart';

class PathfindingHelper {
  static Vector2 getVelocity(Vector2 currentPosition, List<Vector2> checkpoints) {
    if (checkpoints.isEmpty) {
      return Vector2.zero();
    }

    final Vector2 targetCheckpoint = checkpoints.first;
    final Vector2 direction = (targetCheckpoint - currentPosition).normalized();

    // Remove checkpoint if reached
    if ((targetCheckpoint - currentPosition).length < 1) {
      checkpoints.removeAt(0);
    }

    return direction;
  }
}
