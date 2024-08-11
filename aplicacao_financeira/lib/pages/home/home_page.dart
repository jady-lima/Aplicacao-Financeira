import 'package:aplicacao_financeira/models/currency.dart';
import 'package:aplicacao_financeira/models/currency_details.dart';
import 'package:aplicacao_financeira/models/stock.dart';
import 'package:aplicacao_financeira/services/finance_services.dart';
import 'package:aplicacao_financeira/pages/convert/convert.dart';
import 'package:aplicacao_financeira/utils/text_form_utils.dart';
import 'package:aplicacao_financeira/utils/titles_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Currency> futureCurrency;
  late Future<Stock> futureStock;
  CurrencyDetails? dolarDetail;
  CurrencyDetails? realDetail;
  CurrencyDetails? bitcoinDetail;
  CurrencyDetails? euroDetail;

  @override
  void initState() {
    super.initState();
    futureCurrency = fetchCurrency();
    futureStock = fetchStock();
  }

  Future<Currency> fetchCurrency() async {
    return await FinanceService().fetchCurrencyFromApi();
  }

  Future<Stock> fetchStock() async {
    return await FinanceService().fetchStockFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aplicação Financeira",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 69, 142, 201),
        centerTitle: true,
      ),

      body: ListView(
        children: <Widget>[

          Titles.buildTitles("Real hoje"),

          FutureBuilder<Currency>(
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
          ),

          Titles.buildTitles("Bolsas de valores"),

          FutureBuilder<Stock>(
            future: futureStock, 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Nenhum dado disponível.'));
              } else {
                final stock = snapshot.data!;
                final ibovespa = stock.getByStockName('IBOVESPA');
                final ifix = stock.getByStockName('IFIX');
                final nasdaq = stock.getByStockName('NASDAQ');
                final dowjones = stock.getByStockName('DOWJONES');
                final cac = stock.getByStockName('CAC');
                final nikkei = stock.getByStockName('NIKKEI');

                return Text("tudo ok!");
              }
            }
          ),
        ],
      ),
    );
  }
}
