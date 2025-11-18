import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tower_defense/components/buttons/gear.dart';
import 'package:tower_defense/game.dart';

abstract class BaseScreen extends PositionComponent with TapCallbacks, HasGameReference<MyGame> {
  final String title;

  BaseScreen(this.title) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    size = game.size;

    anchor = Anchor.topLeft;

    // add(RectangleComponent(size: size, position: Vector2(0, 0), paint: Paint()..color = const Color(0xFF3B4D5D)));

    add(
      SettingsIcon()
        ..position = Vector2(size.x - 30, 30)
        ..anchor = Anchor.center,
    );
  }
}
