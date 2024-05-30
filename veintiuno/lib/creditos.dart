import 'package:flutter/material.dart';

class Creditos extends StatelessWidget {
  const Creditos({super.key});

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
              'Aplicación creada por:',
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              'Pablo Bruno Mimbrera',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white, // Cambia "Colors.blue" al color que desees
              ),
            ),
          ],
        ),
      ),
    );
  }
}
