import 'package:flutter/material.dart';
import 'package:flutter_snake/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake/screens/game/components/game/game.dart';
import 'package:flutter_snake/screens/game/cubit/game_cubit.dart';

class Portait extends StatelessWidget {
  final int score;
  final Screen screen;

  const Portait({
    Key key,
    @required this.score,
    @required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
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
          width: double.infinity,
          child: Text(
            "$score",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: screen.screenWidth,
          height: screen.screenHeight,
          child: Game(),
        ),
      ],
    );
  }
}
