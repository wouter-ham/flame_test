import 'package:flame/components.dart';
import 'package:flame/text.dart';

class MyWorld extends World {
  @override
  Future<void> onLoad() async {
    // add(Player(position: Vector2(0, 0)));
    add(FpsTextComponent<TextRenderer>());
  }
}
