// Crie uma aplicação financeira que traga informações sobre a Bolsa, SELIC, CDI, dentre outras.
// Funcionalidades básicas esperadas:
  // Cotação de moedas para o Real;
  // Bitcoin nas principais corretoras;
  // Índice das principais bolsas de valores do mundo;
  // Cotação de ações na IBOVESPA;
  // Fundos imobiliários;
  // Preço de BDRs;
  // API para obter dividendos;
  // Lista das maiores altas e baixas no IBOVESPA;
  // Logotipo das empresas listadas;
  // Taxa SELIC e CDI;
// Use a API HG Brasil (https://hgbrasil.com/). 

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const requestCotacao = "https://api.hgbrasil.com/finance?format=json-cors";

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();
}

Future<Map> getDataCotacao() async{
  http.Response responseCotacao = await http.get(Uri.parse(requestCotacao));
  return json.decode(responseCotacao.body);
}

class _HomeState extends State<Home> {
  double _dolarRealController = 0;
  double _bitcoinRealController = 0;
  double _euroRealController = 0;

  double dolar = 0, euro = 0, bitcoin = 0;
  
  void _dolarChange(String text){
    double dolar = double.parse(text);
    _dolarRealController = (dolar * this.dolar).toStringAsFixed(2) as double;
  }

  void _euroChange(String text){
    double euro = double.parse(text);
    _euroRealController = (euro * this.euro).toStringAsFixed(2) as double;
  }

  void _bitcoinChange(String text){
    double bitcoin = double.parse(text);
    _bitcoinRealController = (bitcoin * this.bitcoin).toStringAsFixed(2) as double;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Aplicação Financeira"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),

      body: FutureBuilder<Map>(
        future: getDataCotacao(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  "Carregando os dados...",
                  style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  textAlign: TextAlign.center,
                )
              );
            default:
              if(snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Erro ao carregar dados...",
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                bitcoin = snapshot.data!["results"]["currencies"]["BTC"]["buy"];

                return Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Text(
                                "Dólar ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            Text(
                                "US\$ $_dolarRealController",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            ElevatedButton(
                              child: const Text(
                                "Calculadora",
                                style: TextStyle(color: Colors.blue),
                              ), onPressed: () {
                                //chama a tela da calculadora que converte moedas
                              },
                            )
                          ],
                        ),

                        Column(
                          children: <Widget>[
                            const Text(
                                "Euro ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            Text(
                                "$_euroRealController",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            const Text(
                                "Bitcoin ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            Text(
                                "$_bitcoinRealController",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ), 
                      ]  
                    ),
                    
                  ]
                );
              }
          }
        }
      ),
    );
  }

  Widget buildTextForm(String label, String prefix, Function f){
    return Text(
      f(dolar),
    );
  }

}