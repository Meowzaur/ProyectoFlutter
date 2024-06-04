import 'package:shared_preferences/shared_preferences.dart';

class Puntuacion {
  // Variable puntuación.
  int _puntuacion;

  // Constructor.
  Puntuacion(this._puntuacion);

  // Getter.
  int get puntuacion => _puntuacion;

  // Setter.
  set puntuacion(int valor) {
    _puntuacion = valor;
    _guardarPuntuacion(valor);
  }

  // Método que guarda la puntuación en persistencia.
  Future<void> _guardarPuntuacion(int puntuacion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('puntuacion', puntuacion);
  }

  // Método que carga la puntuación desde persistencia.
  Future<void> cargarPuntuacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Carga la puntuación desde persistencia o establece 0 si no existe.
    _puntuacion = prefs.getInt('puntuacion') ?? 0;
  }

  // Método que incrementa (o disminuye) la puntuación.
  void incrementar(int valor) {
    puntuacion += valor;
  }

  // Método que reinicia la puntuación a 0 y guarda el cambio en persistencia.
  Future<void> resetearPuntuacion() async {
    _puntuacion = 0;
    await _guardarPuntuacion(0);
  }
}
