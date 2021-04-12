import 'package:flutter/material.dart';
import 'package:flutter_snake/models/models.dart';
import 'package:flutter_snake/screens/game/components/game/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake/screens/game/cubit/game_cubit.dart';

class Landscape extends StatelessWidget {
  final int score;
  final Screen screen;
  const Landscape({
    Key key,
    @required this.score,
    @required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.pause,
              color: Colors.white,
            ),
            onPressed: () => context.read<GameCubit>().pause(),
          ),
        ),
        Container(
          width: 200,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            "$score",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: Container(
            width: screen.screenWidth,
            height: screen.screenHeight,
            child: Game(),
          ),
        )
      ],
    );
  }
}
