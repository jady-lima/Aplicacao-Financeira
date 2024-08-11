import 'package:aplicacao_financeira/models/stock_details.dart';

class Stock {
  Map<String, StockDetails> details;

  Stock({
    required this.details
  });

  factory Stock.fromJson(Map<String, dynamic> json){
    if (json['results'] != null && json['results']['stocks'] != null) {
      var stocksJson = json['results']['stocks'] as Map<String, dynamic>;
      Map<String, StockDetails> stockMap = {};

      stocksJson.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          stockMap[key] = StockDetails.fromJson(value);
        }
      });

      return Stock(details: stockMap);
    } else {
      throw Exception("Estrutura JSON inesperada: 'results' ou 'stocks' está ausente");
    }
  }

  StockDetails? getByStockName(String stockName){
    return details[stockName];
  }
}