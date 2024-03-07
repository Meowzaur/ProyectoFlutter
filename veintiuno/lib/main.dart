import 'package:flutter/material.dart';
import 'creditos.dart';
import 'instrucciones.dart';
import 'juego.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF003300,
          <int, Color>{
            50: Color(0xFFE0EEDD),
            100: Color(0xFFB3D6AD),
            200: Color(0xFF80C080),
            300: Color(0xFF4DAA53),
            400: Color(0xFF339933),
            500: Color(0xFF006400),
            600: Color(0xFF005A00),
            700: Color(0xFF004F00),
            800: Color(0xFF004500),
            900: Color(0xFF003300),
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Colors.lightGreen,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: const Text('JUGAR'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Juego()),
                );
              },
            ),
            ListTile(
              title: const Text('Instrucciones'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Instrucciones()),
                );
              },
            ),
            ListTile(
              title: const Text('Créditos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Creditos()),
                );
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡21!',
              style: TextStyle(fontSize: 120.0),
            ),
            SizedBox(height: 70),
            Text(
              'Tu puntuación:',
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              '80 puntos',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
