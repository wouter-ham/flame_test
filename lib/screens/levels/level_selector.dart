import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/screens/base.dart';
import 'package:tower_defense/screens/levels/components/level_selector_button.dart';

class LevelSelectorScreen extends BaseScreen {
  LevelSelectorScreen() : super('LEVEL SELECTOR');

  @override
  void onMount() {
    super.onMount();

    add(
      ColumnComponent(
        gap: 30,
        size: game.size,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Component>[
          LevelSelectorButton(title: 'Level 1', route: 'level-1'),
          LevelSelectorButton(title: 'Level 2', route: 'level-2'),
        ],
      ),
    );
  }
}
