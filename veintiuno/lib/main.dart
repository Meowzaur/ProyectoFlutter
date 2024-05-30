import 'package:flutter/material.dart';
import 'package:veintiuno/modelos/puntuacion.dart';
import 'creditos.dart';
import 'instrucciones.dart';
import 'juego.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final puntuacion = Puntuacion(0);
  await puntuacion.cargarPuntuacion();

  runApp(MyApp(key: UniqueKey(), puntuacion: puntuacion));
}

class MyApp extends StatelessWidget {
  final Puntuacion puntuacion;
  @override
  // ignore: overridden_fields
  final Key key;

  const MyApp({required this.key, required this.puntuacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key, // Utiliza la Key proporcionada
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
      home: HomeScreen(puntuacion: puntuacion, key: UniqueKey()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Puntuacion puntuacion;

  const HomeScreen({required Key key, required this.puntuacion})
      : super(key: key);

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
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡ 21!',
              style: TextStyle(fontSize: 150.0, fontFamily: 'Poker'),
            ),
            const SizedBox(height: 70),
            const Text(
              'Tu puntuación:',
              style: TextStyle(fontSize: 25.0),
            ),
            FutureBuilder<void>(
              future: puntuacion.cargarPuntuacion(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    '${puntuacion.puntuacion} puntos',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold, // Poner el texto en negrita
                      color:
                          Colors.white, // Cambiar el color del texto a blanco
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Juego()),
          );
        },
        label: const Text('JUGAR', style: TextStyle(fontSize: 30.0)),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
