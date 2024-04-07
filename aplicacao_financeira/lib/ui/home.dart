import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const requestCotacao = "https://api.hgbrasil.com/finance?format=json-cors";
const requestFinance = "link";

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();
}

Future<Map> getDataCotacao() async{
  http.Response responseCotacao = await http.get(Uri.parse(requestCotacao));
  return json.decode(responseCotacao.body);
}

Future<Map> getDataFinance() async{
  http.Response responseFinance = await http.get(Uri.parse(requestFinance));
  return json.decode(responseFinance.body);
}

class _HomeState extends State<Home> {
  double _dolarReal = 0;
  double _bitcoinReal = 0;
  double _euroReal = 0;

  double dolar = 0, euro = 0, bitcoin = 0;
  
  void _dolarChange(double text){
    _dolarReal = (text * dolar);
  }

  void _euroChange(double text){
    _euroReal = (text * euro);
  }

  void _bitcoinChange(double text){
    _bitcoinReal = (text * bitcoin);
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

      body: ListView(
        children: <Widget> [
          FutureBuilder<Map>(
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
                    if (snapshot.hasData && snapshot.data!["results"] != null) {
                      final Map<String, dynamic> results = snapshot.data!["results"];

                      if(results["currencies"] != null){
                        final Map<String, dynamic> currencies = results["currencies"];

                        if(currencies["USD"] != null){
                          dolar = double.parse(currencies["USD"]["buy"].toString());
                        } if(currencies["EUR"] != null){
                          euro = double.parse(currencies["EUR"]["buy"].toString());
                        } if(currencies["BTC"] != null){
                          bitcoin = double.parse(currencies["BTC"]["buy"].toString());
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                          "Dólar ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("US\$", dolar),
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
                                ),

                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                          "Euro ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("EUR", euro),
                                      ),

                                      const Text(
                                          "Bitcoin ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("BTC", bitcoin),
                                      ),
                                    ],
                                  ), 
                                ),
                              ]  
                            ),
                            
                          ]
                        ),
                    );
                  }
              }
            }
              return const Text(
                "Erro ao carregar",
              );
            }
          ),

          Text(
            "Parte 2"
          )

        ]
      ),

    );
  }

  Widget buildTextForm(String prefix, double value){
    String formattedValue = value.toStringAsFixed(2);
    return Text(
      '$prefix $formattedValue',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}