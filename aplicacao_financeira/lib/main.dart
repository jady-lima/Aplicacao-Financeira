import 'package:aplicacao_financeira/pages/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Currency App",
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 10, 21, 138)), 
        useMaterial3: true,
      ),
    )
  );
}