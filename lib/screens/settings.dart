import 'package:flutter/material.dart';
import 'package:tower_defense/game.dart';

class SettingsMenu extends StatelessWidget {
  final MyGame game;

  const SettingsMenu({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: game.width,
      height: game.height,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 300,
        height: 250,
        color: Colors.black.withValues(alpha: 0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 20),

            if (game.router.canPop())
              ElevatedButton(
                onPressed: () {
                  game.overlays.remove('SettingsMenu');
                  game.router.popUntilNamed('home');
                  game.resumeEngine();
                },
                child: const Text('Go back to the main menu'),
              ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('SettingsMenu');
                game.resumeEngine();
              },
              child: const Text('Resume Game'),
            ),
          ],
        ),
      ),
    );
  }
}
