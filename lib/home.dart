import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_game/bloc/cubit.dart';
import 'package:xo_game/bloc/state.dart';

import 'bloc/cubit.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        if (state is XISPlay) {
          cubit.activePlayer = 'o';
        } else {
          cubit.activePlayer = 'x';
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "- Welcome in x-o game -".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Text(
                  "it's ${cubit.activePlayer} turn  !".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w300),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                  children: List.generate(
                      9,
                      (index) => InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: cubit.isGameOver
                                ? null
                                : () {
                                    {
                                      cubit.playGame(index);
                                    }
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context).shadowColor),
                              child: Center(
                                  child: Text(
                                cubit.playerX.contains(index)
                                    ? 'x'
                                    : cubit.playerO.contains(index)
                                        ? 'o'
                                        : '',
                                style: TextStyle(
                                    fontSize: 60,
                                    color: cubit.playerX.contains(index)
                                        ? Colors.blue
                                        : Colors.pink),
                              )),
                            ),
                          )),
                )),
                Text(
                  cubit.result == 'none' ? '' : " ${cubit.result} ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    cubit.repeat();
                  },
                  icon: const Icon(
                    Icons.replay,
                    size: 30,
                  ),
                  label: const Text(
                    "Repeat The Game",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
