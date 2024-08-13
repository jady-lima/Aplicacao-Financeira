import 'package:aplicacao_financeira/models/stock.dart';
import 'package:flutter/material.dart';

class FutureBuilderStock{
  static Widget buildFutureBuilderCurrency(Future<Stock> futureStock){
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

          return Text("tudo ok!");
        }
      }
    );
  }
}