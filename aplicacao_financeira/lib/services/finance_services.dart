import 'package:aplicacao_financeira/models/currency.dart';
import 'package:aplicacao_financeira/models/stock.dart';
import 'package:aplicacao_financeira/shared/api_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FinanceService {
  Future<Currency> fetchCurrencyFromApi() async {
    final response = await http.get(Uri.parse(ApiResquest.requestCurrency));

    if (response.statusCode == 200) {
      return Currency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar dados: currencies');
    }
  }

  Future<Stock> fetchStockFromApi() async {
    final response = await http.get(Uri.parse(ApiResquest.requestCurrency));

    if (response.statusCode == 200) {
      return Stock.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar dados stocks');
    }
  }
}