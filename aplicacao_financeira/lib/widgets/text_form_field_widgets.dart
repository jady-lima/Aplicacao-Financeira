import 'package:flutter/material.dart';

class TextFormFieldWidgets{
  static Widget buildTextFormField(String label, String prefix, TextEditingController controller, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 64, 80, 107)),
        border: const OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: const TextStyle(color: Color.fromARGB(255, 62, 93, 109), fontSize: 25.0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}