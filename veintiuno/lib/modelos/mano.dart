import 'package:flutter/foundation.dart';
import 'package:veintiuno/modelos/baraja.dart';

class Mano {
  List<int> cartasEnMano;
  bool pasar;

  Mano()
      : cartasEnMano = <int>[],
        pasar = false;

  void robarCarta(Baraja baraja) {
    if (baraja.cartas.isNotEmpty) {
      cartasEnMano.add(baraja.cartas.removeLast());
      pasar = false;
    } else {
      if (kDebugMode) {
        print('La baraja está vacía. No se pueden robar más cartas.');
      }
    }
  }

  void pasarTurno() {
    pasar = true;
  }

  void mostrarCartasEnMano() {
    if (kDebugMode) {
      print('Cartas en la mano:');
    }
    for (int i = 0; i < cartasEnMano.length; i++) {
      if (kDebugMode) {
        print('${i + 1}: ${cartasEnMano[i]}');
      }
    }
  }

  bool suEstado() {
    return pasar;
  }
}
