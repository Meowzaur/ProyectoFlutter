import 'package:veintiuno/modelos/baraja.dart';

class Mano {
  // Lista de enteros.
  List<int> cartasEnMano;
  // Variable booleana para indicar si el jugador decide pasar su turno.
  bool pasar;

  // Constructor.
  Mano()
      : cartasEnMano = <int>[], // Inicializa como una lista vacía.
        pasar = false;

  // Método para robar una carta de la baraja.
  void robarCarta(Baraja baraja) {
    // Verifica si la baraja tiene cartas disponibles.
    if (baraja.cartas.isNotEmpty) {
      // Agrega la última carta de la baraja a la mano del jugador.
      cartasEnMano.add(baraja.cartas.removeLast());
      // Indica que el jugador no está pasando su turno.
      pasar = false;
    }
  }

  // Método para pasar el turno.
  void pasarTurno() {
    // Establece 'pasar' como true.
    pasar = true;
  }

  // Método para obtener el estado de 'pasar'.
  bool suEstado() {
    return pasar;
  }
}
