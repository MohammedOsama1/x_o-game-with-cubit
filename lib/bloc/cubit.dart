import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_game/bloc/state.dart';

extension ContainAll on List {
  bool containAll(int x, int y, int z) {
    return contains(x) && contains(y) && contains(z);
  }
}

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());
  static HomeCubit get(context) => BlocProvider.of(context);


  List playerX = [];
  List playerO = [];
  String activePlayer = 'x';
  String result = 'none';
  bool isGameOver = false;
  bool isSwitched = false;



  void playGame(int index) {
    if (activePlayer == 'x') {
      if (!playerO.contains(index)) {
        playerX.add(index);
        emit(XISPlay());
      }
    } else {
      if (!playerX.contains(index)) {
        playerO.add(index);
        emit(OISPlay());
      }
    }
    checkWinner();
    endGame(index);
  }
  void repeat() {
    playerX = [];
     result = 'none';
    playerO = [];
    isGameOver = false;
    emit(ClearAll());
  }
  void checkWinner() {
    if (playerX.containAll(0, 1, 2) ||
        playerX.containAll(3, 4, 5) ||
        playerX.containAll(6, 7, 8) ||
        playerX.containAll(0, 3, 6) ||
        playerX.containAll(1, 4, 7) ||
        playerX.containAll(2, 5, 8) ||
        playerX.containAll(2, 4, 6) ||
        playerX.containAll(0, 4, 8)) {
      result = " X is the Winner!".toUpperCase();
      isGameOver = true;
      emit(XIsWinner());
    }
    if (playerO.containAll(0, 1, 2) ||
        playerO.containAll(3, 4, 5) ||
        playerO.containAll(6, 7, 8) ||
        playerO.containAll(0, 3, 6) ||
        playerO.containAll(1, 4, 7) ||
        playerO.containAll(2, 5, 8) ||
        playerO.containAll(2, 4, 6) ||
        playerO.containAll(0, 4, 8)) {
      result = " o is the Winner!".toUpperCase();
      isGameOver = true;
      emit(OIsWinner());

    }
  }
  void endGame(index){
    if(result == 'none') {
      if ( (playerX.length == 5 && playerO.length == 4 )){
        isGameOver = true;
        result = 'draw';
        emit(Draw());

      }
    }

  }
}
