import 'package:aplicacao_financeira/pages/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Currency App",
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(179, 21, 57, 101)
        ), 
        useMaterial3: true,
      ),
    )
  );
}