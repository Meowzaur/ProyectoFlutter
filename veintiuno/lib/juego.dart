import 'package:flutter/material.dart';

class Juego extends StatelessWidget {
  const Juego({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dealer:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              'Roba',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'AQUÍ VAN LAS CARTAS DEL ADVERSARIO',
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              'Suma: 9 + ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'BARAJA',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Suma: 15',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              'AQUÍ VAN TUS CARTAS',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),
            Text(
              'Tú:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              'Pasas',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: null,
                  child: Text('Robar'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Pasar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
