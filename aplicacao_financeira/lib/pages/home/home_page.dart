import 'package:aplicacao_financeira/models/currency.dart';
import 'package:aplicacao_financeira/models/currency_details.dart';
import 'package:aplicacao_financeira/models/stock.dart';
import 'package:aplicacao_financeira/services/finance_services.dart';
import 'package:aplicacao_financeira/widgets/future_builder_currency_widget.dart';
import 'package:aplicacao_financeira/widgets/future_builder_stocks_widgets.dart';
import 'package:aplicacao_financeira/widgets/titles_widgets.dart';
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

          FutureBuilderCurrency.buildFutureBuilderCurrency(futureCurrency),

          Titles.buildTitles("Bolsas de valores"),

          FutureBuilderStock.buildFutureBuilderCurrency(futureStock),
        ],
      ),
    );
  }
}
