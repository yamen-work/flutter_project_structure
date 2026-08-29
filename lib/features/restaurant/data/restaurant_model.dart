class RestaurantModel {
  final String id;
  final String location;
  final String name;
  final double rating;

  const RestaurantModel({
    required this.id,
    required this.location,
    required this.name,
    required this.rating,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      location: json['location'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'name': name,
      'rating': rating,
    };
  }
}