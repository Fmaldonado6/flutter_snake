import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake/screens/game/cubit/game_cubit.dart';


class Game extends StatefulWidget {
  Game({
    Key key,
  }) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  GameCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<GameCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
            color: Colors.black,
          ),
          child: Stack(
            children: cubit.draw(),
          ),
        );
      },
    );
  }


}
