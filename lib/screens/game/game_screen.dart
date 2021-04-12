import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake/models/models.dart';
import 'package:flutter_snake/screens/game/components/dialogs/gameOverDialog.dart';
import 'package:flutter_snake/screens/game/components/dialogs/pauseDialog.dart';
import 'package:flutter_snake/screens/game/components/layouts/landscape.dart';
import 'package:flutter_snake/screens/game/components/layouts/portrait.dart';

import 'cubit/game_cubit.dart';
import 'cubit/game_state.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var widgetHeight = 0.0;
  var widgetWidth = 0.0;
  final sensitivity = 2;
  final gameCubit = GameCubit();
  var score = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    widgetWidth = width - 40;
    widgetHeight = widgetWidth / (3 / 4);

    if (widgetHeight > height - 180) {
      widgetHeight = height - 20;
      widgetWidth = widgetHeight * (3 / 4);
    }

    gameCubit.setScreen(Screen(widgetWidth, widgetHeight));

    gameCubit.startGame();

    return BlocProvider(
      create: (context) => gameCubit,
      child: BlocConsumer(
        listener: (context, state) {
          if (state is GameState) gameState(state.state);
        },
        bloc: gameCubit,
        builder: (context, state) {
          if (state is AddPoint) score = state.score;
          return Scaffold(
            body: GestureDetector(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                width: double.infinity,
                height: double.infinity,
                child: height > width
                    ? Portait(
                        screen: gameCubit.screen,
                        score: score,
                      )
                    : Landscape(
                        screen: gameCubit.screen,
                        score: score,
                      ),
              ),
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > sensitivity)
                  gameCubit.fingerSwipe(SwipeDirection.right);
                else if (details.delta.dx < -sensitivity)
                  gameCubit.fingerSwipe(SwipeDirection.left);
              },
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > sensitivity)
                  gameCubit.fingerSwipe(SwipeDirection.up);
                else if (details.delta.dy < -sensitivity)
                  gameCubit.fingerSwipe(SwipeDirection.down);
              },
            ),
          );
        },
      ),
    );
  }

  void gameState(GameStates state) {
    if (state == GameStates.gameOver)
      GameOverDialog().show(
        context: context,
        onRestart: () {
          gameCubit.restart();
          Navigator.pop(context);
        },
      );

    if (state == GameStates.paused)
      PauseDialog().show(
        context: context,
        onResume: () {
          gameCubit.resume();
          Navigator.pop(context);
        },
      );
  }
}
