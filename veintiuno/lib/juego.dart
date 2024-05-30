import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veintiuno/modelos/baraja.dart';
import 'package:veintiuno/modelos/mano.dart';

class Juego extends StatefulWidget {
  const Juego({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _JuegoState createState() => _JuegoState();
}

class _JuegoState extends State<Juego> {
  bool _botonesActivos = true;
  late Mano manoJugador;
  late Mano manoAdversario;
  late Baraja baraja;

  @override
  void initState() {
    super.initState();
    manoJugador = Mano();
    manoAdversario = Mano();
    baraja = Baraja();
    manoJugador.robarCarta(baraja);
    manoAdversario.robarCarta(baraja);
  }

  void _realizarAccionRobar(Mano mano) {
    if (_botonesActivos) {
      setState(() {
        _botonesActivos = false;
        mano.robarCarta(baraja);
        mano.mostrarCartasEnMano();
        baraja.mostrarCartas();
      });
    }
  }

  void _realizarAccionPasar(Mano mano) {
    if (_botonesActivos) {
      setState(() {
        _botonesActivos = false;
        mano.pasarTurno();
      });
    }
  }

  void _turnoContrario() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        if (_sumarCartas(manoAdversario.cartasEnMano) < 15) {
          _realizarAccionRobar(manoAdversario);
        } else {
          _realizarAccionPasar(manoAdversario);
        }
        _comprobarYFinalizar();
        _botonesActivos = true;
      });
    });
  }

  int _sumarCartas(List<int> cartas) {
    return cartas.fold(0, (prev, element) => prev + element);
  }

  void _comprobarYFinalizar() {
    if (manoJugador.suEstado() && manoAdversario.suEstado()) {
      if (kDebugMode) {
        print('FFIIIIINNN.');
      }
    } else {
      if (kDebugMode) {
        print('CONTINUAAAAAD.');
      }
    }
  }

  String _mostrarPrimeraCarta(List<int> cartas) {
    if (cartas.isEmpty) {
      return '0';
    } else if (cartas.length == 1) {
      return '${cartas.first}';
    } else {
      return '${cartas.first} + ?';
    }
  }

  String _estadoJugador(Mano mano) {
    if (mano.suEstado()) {
      return 'Pasa';
    } else {
      return 'Roba';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dealer:',
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
            const Text(
              'AQUÍ VAN LAS CARTAS DEL ADVERSARIO',
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              'Suma: ${_mostrarPrimeraCarta(manoAdversario.cartasEnMano)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'BARAJA: ${baraja.cartas.length} Cartas',
              style: const TextStyle(
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'Suma: ${_sumarCartas(manoJugador.cartasEnMano)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const Text(
              'AQUÍ VAN TUS CARTAS',
              style: TextStyle(fontSize: 30.0),
            ),
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
