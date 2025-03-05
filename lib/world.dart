import 'package:flame/components.dart';
import 'package:flame/text.dart';

class MyWorld extends World {
  @override
  Future<void> onLoad() async {
    add(FpsTextComponent<TextRenderer>());
  }
}
