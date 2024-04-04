import 'package:flutter/material.dart';
import 'package:aplicacao_financeira/ui/home.dart';

void main() async{
  runApp(MaterialApp(
    title: "Aplicação Financeira",
    home: Home(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 15, 82, 138)),
      useMaterial3: true,
    ),
  ));
}