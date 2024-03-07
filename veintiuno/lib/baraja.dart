import 'package:flutter/material.dart';

class Baraja {
  //List<int> cartas;

  //Baraja() {
  //  cartas = List.generate(11, (index) => index + 1);
  //}

  Widget construirCarta(int numero) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          numero.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
