class StockDetails {
  final String? name;
  final String? location;
  final double? points;
  final double? variation;

  StockDetails({
    required this.name,
    required this.location,
    required this.points,
    required this.variation
  });

  factory StockDetails.fromJson(Map<String, dynamic> json){
    return StockDetails(
      name: json['name'] as String, 
      location: json['location'] as String, 
      points: json['points']?.toDouble(), 
      variation: json['variation']?.toDouble()
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'location': location,
    'points': points,
    'variation': variation
  };
}