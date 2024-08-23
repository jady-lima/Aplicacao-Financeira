import 'package:flutter/material.dart';

class TextFormFieldWidgets{
  static Widget buildTextFormField(String label, String prefix, TextEditingController controller, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(179, 21, 57, 101)),
        border: const OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: const TextStyle(color: Color.fromARGB(179, 21, 57, 101), fontSize: 25.0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}