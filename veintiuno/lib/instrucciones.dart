import 'package:flutter/material.dart';

class Instrucciones extends StatelessWidget {
  const Instrucciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡ 21!',
              style: TextStyle(fontSize: 150.0, fontFamily: 'Poker'),
            ),
            SizedBox(height: 70),
            Text(
              '"Intenta conseguir 21 puntos sin pasarte."',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10),
            Text(
              '"Roba tantas cartas como puedas para acercarte a 21."',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10),
            Text(
              '"Gana quien más cerca se quede al 21 sin pasarse."',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10),
            Text(
              '"Mejora tu puntuación ganando tantas partidas como puedas."',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
