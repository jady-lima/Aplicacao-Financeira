import 'package:flutter/material.dart';

class Titles {
  static Widget buildTitles(String label){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 69, 142, 201),
          ),
        ),
      ),
    );
  }
}