import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class MyCamera extends CameraComponent {
  MyCamera();

  MyCamera.withFixedResolution({
    required double width,
    required double height,
    super.world,
    Viewfinder? viewfinder,
    super.backdrop,
    super.hudComponents,
    super.children,
    super.key,
  }) : super(
         viewport: FixedResolutionViewport(resolution: Vector2(width, height)),
         viewfinder: viewfinder ?? Viewfinder(),
       );
}
