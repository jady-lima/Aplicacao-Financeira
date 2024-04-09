import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'convert.dart';

//chave: 6d110d67
/*
    Cotação de ações na IBOVESPA;
    Fundos imobiliários;
    Preço de BDRs;
    API para obter dividendos;
    Lista das maiores altas e baixas no IBOVESPA;
    * Logotipo das empresas listadas;
    * Taxa SELIC e CDI;
*/

const requestCotacao = "https://api.hgbrasil.com/finance?key=6d110d67";

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();
}

Future<Map> getDataCotacao() async{
  http.Response responseCotacao = await http.get(Uri.parse(requestCotacao));
  return json.decode(responseCotacao.body);
}

class _HomeState extends State<Home> {
  double dolar = 0, euro = 0, bitcoin = 0, real = 0;
  double blockchain = 0, coinbase = 0, bitstamp = 0, foxbit = 0;
  double ibovespa = 0, ifix = 0, nasdaq = 0, dowjones = 0, cac = 0, nikkei = 0;
  double selic = 0, cdi = 0;
 
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

          buildTitles("Real no Mercado"),
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
                        } if(currencies["BRL"] != null){
                          real = double.parse(currencies["BRL"]["buy"].toString());
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Stack(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                          "Dólar",
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Convert(dolar, euro, real, bitcoin)),
                                          );
                                        },
                                      )
                                    ],
                                  ), 
                                ),

                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                          "Euro",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("EUR", euro),
                                      ),

                                      const Text(
                                          "Bitcoin",
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
            return const Text("Erro ao carregar");
            }
          ),

          buildTitles("Variação Bitcoin"),
          FutureBuilder<Map>(
            future: getDataCotacao(), 
            builder: (context, snapshot){
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                    child: Text(
                      "Carregando os dados...",
                      style: TextStyle(color: Colors.blue, fontSize: 10.0),
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

                      if(results["bitcoin"] != null){
                        final Map<String, dynamic> currencies = results["bitcoin"];

                        if(currencies["blockchain_info"] != null){
                          blockchain = double.parse(currencies["blockchain_info"]["last"].toString());
                        } if(currencies["coinbase"] != null){
                          coinbase = double.parse(currencies["coinbase"]["last"].toString());
                        } if(currencies["bitstamp"] != null){
                          bitstamp = double.parse(currencies["bitstamp"]["last"].toString());
                        } if(currencies["foxbit"] != null){
                          foxbit = double.parse(currencies["foxbit"]["last"].toString());
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
                                          "Blockchain ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("BTC ", blockchain),
                                      ),

                                      const Text(
                                          "Coinbase ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("BTC ", coinbase),
                                      ),
                                    ],
                                  ), 
                                ),

                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                          "Bitstamp ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("BTC", bitstamp),
                                      ),

                                      const Text(
                                          "Foxbit ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: buildTextForm("BTC", foxbit),
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
            return const Text("Erro ao carregar",);
            }
          ),

          buildTitles("Bolsa de Valores"),
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

                      if(results["stocks"] != null){
                        final Map<String, dynamic> stocks = results["stocks"];

                        if(stocks["IBOVESPA"] != null){
                          ibovespa = double.parse(stocks["IBOVESPA"]["variation"].toString());
                        } if(stocks["IFIX"] != null){
                          ifix = double.parse(stocks["IFIX"]["variation"].toString());
                        } if(stocks["NASDAQ"] != null){
                          nasdaq = double.parse(stocks["NASDAQ"]["variation"].toString());
                        } if(stocks["DOWJONES"] != null){
                          dowjones = double.parse(stocks["DOWJONES"]["variation"].toString());
                        } if(stocks["CAC"] != null){
                          cac = double.parse(stocks["CAC"]["variation"].toString());
                        } if(stocks["NIKKEI"] != null){
                          nikkei = double.parse(stocks["NIKKEI"]["variation"].toString());
                        }

                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: <Widget>[
                            buildStocksTitles("IBOVESPA", ibovespa),
                            buildStocksTitles("IFIX", ifix),
                            buildStocksTitles("NASDAQ", nasdaq),
                            buildStocksTitles("DOWJONES", dowjones),
                            buildStocksTitles("CAC", cac),
                            buildStocksTitles("NIKKEI", nikkei),
                          ]
                        )
                    );
                  }
              }
            }
            return const Text("Erro ao carregar");
            }
          ),
        
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

  Widget buildTitles(String label){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child:  Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey
          ),
        ),
      ), 
    );
  }

  Widget buildStocksTitles(String label, double stocks){
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
            width: 2.0
          )
        ),

        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 143, 180, 199)
                  ),
                ),
              )
            ),

            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(left: 200.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Text(
                  "$stocks",
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 48, 57, 61)
                  ),
                ),
              )
            ),
          ]
        ),
      ),
    );
  }

}