import 'package:aplicacao_financeira/models/stock.dart';
import 'package:aplicacao_financeira/widgets/titles_widgets.dart';
import 'package:flutter/material.dart';

class FutureBuilderStock{
  static Widget buildFutureBuilderStocks(Future<Stock> futureStock){
    return FutureBuilder<Stock>(
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

          return Container(
            margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25, right: 25),
            child: Column(
              children: <Widget>[
                TitlesWidgets.buildStocksTitles(ibovespa),
                TitlesWidgets.buildStocksTitles(ifix),
                TitlesWidgets.buildStocksTitles(nasdaq),
                TitlesWidgets.buildStocksTitles(dowjones),
                TitlesWidgets.buildStocksTitles(cac),
                TitlesWidgets.buildStocksTitles(nikkei),
              ]
            )
          );
        }
      }
    );
  }
}