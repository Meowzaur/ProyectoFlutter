import 'package:flutter/foundation.dart';

class Baraja {
  List<int> cartas;

  Baraja() : cartas = <int>[] {
    cartas = List<int>.generate(11, (index) => index + 1);

    cartas.shuffle();
  }

  void mostrarCartas() {
    if (kDebugMode) {
      print('Cartas en la baraja:');
    }
    for (int i = 0; i < cartas.length; i++) {
      if (kDebugMode) {
        print('${i + 1}: ${cartas[i]}');
      }
    }
  }
}
