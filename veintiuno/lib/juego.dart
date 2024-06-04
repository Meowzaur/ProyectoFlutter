import 'dart:async';
import 'package:flutter/material.dart';
import 'package:veintiuno/modelos/baraja.dart';
import 'package:veintiuno/modelos/mano.dart';
import 'package:veintiuno/modelos/puntuacion.dart';

class Juego extends StatefulWidget {
  final Puntuacion puntuacion;

  // Constructor.
  const Juego({Key? key, required this.puntuacion}) : super(key: key);

  @override
  // Crea el estado 'Juego'.
  // ignore: library_private_types_in_public_api
  _JuegoState createState() => _JuegoState();
}

// Estado 'Juego'.
class _JuegoState extends State<Juego> {
  bool _botonesActivos = true;
  late Mano manoJugador;
  late Mano manoAdversario;
  late Baraja baraja;

// Método que inicializa la mano del jugador, la del adversario, la baraja, y ambas manos roban una carta.
  @override
  void initState() {
    super.initState();
    manoJugador = Mano();
    manoAdversario = Mano();
    baraja = Baraja();
    manoJugador.robarCarta(baraja);
    manoAdversario.robarCarta(baraja);
  }

  // Método para sumar las cartas en una mano.
  int _sumarCartas(List<int> cartas) {
    return cartas.fold(0, (prev, element) => prev + element);
  }

  // Método para mostrar el número de la primera carta de una mano. El resto de cartas se muestran como '?'
  String _mostrarPrimeraCarta(List<int> cartas) {
    if (cartas.isEmpty) {
      return '0';
    } else if (cartas.length == 1) {
      return '${cartas.first}';
    } else {
      return '${cartas.first} + ?';
    }
  }

  // Método para realizar la acción de robar una carta.
  void _realizarAccionRobar(Mano mano) {
    setState(() {
      _botonesActivos = !_botonesActivos; // Alterna el estado de los botones.
      mano.robarCarta(baraja);
    });
  }

  // Método para realizar la acción de pasar el turno.
  void _realizarAccionPasar(Mano mano) {
    setState(() {
      _botonesActivos = !_botonesActivos; // Alterna el estado de los botones.
      mano.pasarTurno();
    });
  }

  // Método para gestionar el turno del adversario.
  void _turnoContrario() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        if (_sumarCartas(manoAdversario.cartasEnMano) < 17) {
          _realizarAccionRobar(
              manoAdversario); // El adversario roba si su mano es menor que 17.
        } else {
          _realizarAccionPasar(
              manoAdversario); // El adversario pasa en caso contrario.
        }
        _comprobarYFinalizar(); // Comprueba y finaliza el juego si es posible.
      });
    });
  }

  // Método para comprobar el estado del juego y finalizar si es necesario.
  void _comprobarYFinalizar() {
    int miMano = _sumarCartas(manoJugador.cartasEnMano);
    int suMano = _sumarCartas(manoAdversario.cartasEnMano);
    int valor = 0;
    // El juego termina cuando ambos jugadores pasan turno.
    if (manoJugador.suEstado() && manoAdversario.suEstado()) {
      if (miMano <= 21 && suMano <= 21) {
        // Si ambos jugadores no sobrepasan el 21.
        valor = miMano - suMano;
      } else if (miMano <= 21 && suMano > 21) {
        // Si sólo el advesario sobrepasa el 21.
        valor = 10;
      } else if (miMano > 21 && suMano <= 21) {
        // Si sólo el jugador sobrepasa el 21.
        valor = -10;
      } else if (miMano > 21 && suMano > 21) {
        // Si ambos jugadores sobrepasan el 21.
        valor = -miMano + suMano;
      }
      widget.puntuacion.incrementar(valor); // Suma y actualiza la puntuación.
      showDialog(
        // Ventana emergente de resultados
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Resultado del juego"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Valor de mi mano: $miMano"),
                Text("Valor de la mano contraria: $suMano"),
                Text("Puntuación obtenida: $valor"),
              ],
            ),
            // Al pulsar 'OK', cierra la ventana emergente y abre la ventana 'main'.
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Método para mostrar el estado del jugador.
  String _estadoJugador(Mano mano) {
    if (mano.suEstado()) {
      return 'Pasa';
    } else {
      return 'Roba';
    }
  }

  // Método para construir la visualización de las cartas del jugador.
  Widget _buildCartasMias(List<int> cartas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cartas.map((carta) {
        return Container(
          width: 55,
          height: 80,
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              '$carta',
              style: const TextStyle(
                fontSize: 33.0,
                fontFamily: 'Numeros',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Método para construir la visualización de las cartas del adversario.
  Widget _buildCartasAdversario(List<int> cartas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cartas.asMap().entries.map((entry) {
        final index = entry.key;
        final carta = entry.value;
        return Container(
          width: 55,
          height: 80,
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              index == 0 ? '$carta' : '?',
              style: const TextStyle(
                fontSize: 33.0,
                fontFamily: 'Numeros',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

// Ventana de juego.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Adversario:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              _estadoJugador(manoAdversario),
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 20),
            _buildCartasAdversario(manoAdversario.cartasEnMano),
            Text(
              'Suma: ${_mostrarPrimeraCarta(manoAdversario.cartasEnMano)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 240,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Quedan ${baraja.cartas.length} cartas',
                  style: const TextStyle(
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Suma: ${_sumarCartas(manoJugador.cartasEnMano)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            _buildCartasMias(manoJugador.cartasEnMano),
            const SizedBox(height: 20),
            const Text(
              'Tú:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              _estadoJugador(manoJugador),
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _botonesActivos
                      ? () {
                          _realizarAccionRobar(manoJugador);
                          _turnoContrario();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Robar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _botonesActivos
                      ? () {
                          _realizarAccionPasar(manoJugador);
                          _turnoContrario();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Pasar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
