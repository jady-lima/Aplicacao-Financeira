class CurrencyDetails{
  final String name;
  final double? buy;
  final double? sell;
  final double? variation;

  CurrencyDetails({
    required this.name,
    required this.buy,
    required this.sell,
    required this.variation,
  });

  factory CurrencyDetails.fromJson(Map<String, dynamic> json) {
    return CurrencyDetails(
      name: json['name'] as String,
      buy: json['buy']?.toDouble(),
      sell: json['sell']?.toDouble(),
      variation: json['variation']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'buy': buy,
    'sell': sell,
    'variation': variation
  };
}