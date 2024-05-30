import 'package:shared_preferences/shared_preferences.dart';

class Puntuacion {
  int _puntuacion;

  Puntuacion(this._puntuacion);

  int get puntuacion => _puntuacion;

  set puntuacion(int valor) {
    _puntuacion = valor;
    _guardarPuntuacion(valor);
  }

  Future<void> _guardarPuntuacion(int puntuacion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('puntuacion', puntuacion);
  }

  Future<void> cargarPuntuacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _puntuacion = prefs.getInt('puntuacion') ?? 0;
  }

  void incrementar(int valor) {
    _puntuacion = _puntuacion + valor;
    _guardarPuntuacion(_puntuacion);
  }
}
