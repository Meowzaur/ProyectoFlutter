import 'dart:io';
import 'package:flutter/material.dart';
import 'package:veintiuno/modelos/puntuacion.dart';
import 'creditos.dart';
import 'instrucciones.dart';
import 'juego.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final puntuacion =
      Puntuacion(0); // Crea una instancia de Puntuacion con valor inicial 0.
  await puntuacion.cargarPuntuacion(); // Carga la puntuación guardada.

  runApp(MyApp(key: UniqueKey(), puntuacion: puntuacion));
}

class MyApp extends StatelessWidget {
  final Puntuacion puntuacion; // Variable puntuación.
  @override
  // ignore: overridden_fields
  final Key key;

  // Constructor.
  const MyApp({required this.key, required this.puntuacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Método que construye la interfaz de usuario.
    return MaterialApp(
      key: key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          // Color del drawer.
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

class HomeScreen extends StatefulWidget {
  final Puntuacion puntuacion; // Variable puntuación.

  // Constructor.
  const HomeScreen({required Key key, required this.puntuacion})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ValueNotifier<int>
      _puntuacionNotifier; // Notificador para la puntuación.

  // Inicializa la aplicación.
  @override
  void initState() {
    super.initState();
    _puntuacionNotifier = ValueNotifier<int>(widget.puntuacion.puntuacion);
  }

  // Función para actualizar la puntuación.
  void _actualizarPuntuacion() {
    setState(() {
      widget.puntuacion.cargarPuntuacion().then((_) {
        _puntuacionNotifier.value = widget.puntuacion.puntuacion;
      });
    });
  }

  // Ventana emergente para confirmar el reseteo de la puntuación.
  void _mostrarDialogoConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Desea resetear los puntos?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                widget.puntuacion.resetearPuntuacion();
                _actualizarPuntuacion();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Construye la interfaz de usuario.
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
                      builder: (context) =>
                          const Instrucciones()), // Abre la ventana Instrucciones.
                );
              },
            ),
            ListTile(
              title: const Text('Créditos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Creditos()), // Abre la ventana Créditos.
                );
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                exit(0); // Sale de la aplicación.
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _mostrarDialogoConfirmacion(
                      context); // Abre la ventana emergente.
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('Reset puntos'),
              ),
            ],
          ),
          Expanded(
            child: Center(
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
                  ValueListenableBuilder<int>(
                    valueListenable: _puntuacionNotifier,
                    builder: (BuildContext context, int value, Widget? child) {
                      return Text(
                        '$value puntos',
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Juego(
                  puntuacion: widget.puntuacion), // Abre la ventana Juego.
            ),
          ).then((_) {
            _actualizarPuntuacion();
          });
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
