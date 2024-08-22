import 'package:aplicacao_financeira/models/currency.dart';
import 'package:aplicacao_financeira/pages/convert/convert.dart';
import 'package:aplicacao_financeira/widgets/text_form_widgets.dart';
import 'package:flutter/material.dart';

class FutureBuilderCurrency{
  static Widget buildFutureBuilderCurrency(Future<Currency> futureCurrency){
    return FutureBuilder<Currency>(
      future: futureCurrency,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Nenhum dado disponível.'));
        } else {
          final currency = snapshot.data!;
          final dolarDetail = currency.getByCurrencyName('USD');
          final euroDetail = currency.getByCurrencyName('EUR');
          final bitcoinDetail = currency.getByCurrencyName('BTC');
          final realDetail = currency.getByCurrencyName('BRL');

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
                          Text(
                            dolarDetail?.name ?? "Carregando dados...",
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextForms.buildTextForm("US\$", dolarDetail?.buy),
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Calculadora',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 69, 142, 201),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Convert(
                                    dolarDetail?.buy, 
                                    euroDetail?.buy, 
                                    realDetail?.buy, 
                                    bitcoinDetail?.buy
                                  ),
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            euroDetail?.name ?? "Carregando dados...",
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextForms.buildTextForm("EUR", euroDetail?.buy),
                          ),
                          const Text(
                            "Bitcoin",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextForms.buildTextForm("BTC", bitcoinDetail?.buy),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}