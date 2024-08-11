import 'package:flutter/material.dart';

class TextForms{
  static Widget buildTextForm(String prefix, double? value){
    String formattedValue = value != null ? value.toStringAsFixed(2) : "Carregando...";
    return Text(
      '$prefix $formattedValue',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}