import 'dart:math' as math;

class AssetHelper {
  final int down = 0;
  final int left = 1;
  final int upLeft = 2;
  final int up = 3;
  final int upRight = 4;
  final int right = 5;

  int getRow(double angle) {
    if (angle < 0) {
      angle += 2 * math.pi;
    }
    angle = angle % (2 * math.pi);

    const double slice = math.pi / 8;

    if (angle > slice * 15 || angle <= slice * 3) {
      print('0');
      return up;
    } else if (angle > slice * 3 && angle <= slice * 5) {
      print('1');
      return right;
    } else if (angle > slice * 5 && angle <= slice * 9) {
      print('2');
      return down;
    } else if (angle > slice * 9 && angle <= slice * 11) {
      print('3');
      return left;
    } else if (angle > slice * 11 && angle <= slice * 13) {
      print('4');
      return left;
    } else if (angle > slice * 13 && angle <= slice * 15) {
      print('5');
      return right;
    }

    print('6');
    return down;
  }
}
