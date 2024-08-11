import 'package:aplicacao_financeira/models/currency_details.dart';

class Currency{
  Map<String, CurrencyDetails> details;

  Currency({required this.details});

  factory Currency.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null && json['results']['currencies'] != null) {
      var currenciesJson = json['results']['currencies'] as Map<String, dynamic>;
      Map<String, CurrencyDetails> currenciesMap = {};

      currenciesJson.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          currenciesMap[key] = CurrencyDetails.fromJson(value);
        }
      });

      return Currency(details: currenciesMap);
    } else {
      throw Exception("Estrutura JSON inesperada: 'results' ou 'currencies' está ausente");
    }
  }

  CurrencyDetails? getByCurrencyName(String currencyCode) {
    return details[currencyCode];
  }
}