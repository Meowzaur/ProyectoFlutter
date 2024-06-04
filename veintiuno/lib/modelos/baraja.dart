class Baraja {
  // Define una lista de enteros.
  List<int> cartas;

  // Constructor.
  Baraja() : cartas = <int>[] {
    // Inicializa la lista generando números del 1 al 11.
    cartas = List<int>.generate(11, (index) => index + 1);

    // Mezcla los elementos de la lista.
    cartas.shuffle();
  }
}
