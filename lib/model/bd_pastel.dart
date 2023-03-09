import 'package:flutter/foundation.dart';

class PastelDb {
  int id;
  String name;
  String sabor;
  String dibujo;
  String color;
  String especial;
  int precio;
  String tamano;
  String forma;
  String galleta_o_pan;
  //*

  PastelDb({
    required this.id,
    required this.name,
    required this.sabor,
    required this.dibujo,
    required this.color,
    required this.especial,
    required this.precio,
    required this.tamano,
    required this.forma,
    required this.galleta_o_pan,
  });

  factory PastelDb.fromJson(Map json) {
    return PastelDb(
        id: json["id"],
        name: json["nombre"],
        sabor: json["sabor"],
        dibujo: json["dibujo"],
        color: json["color"],
        especial: json["especial"],
        precio: json["precio"],
        tamano: json["tamano"],
        forma: json["forma"],
        galleta_o_pan: json["galleta_o_pan"]);
  }
}
