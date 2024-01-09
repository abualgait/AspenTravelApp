class TravelApiResponse {
  List<Category> categories;
  List<City> popularCities;
  List<City> recommendedCities;

  TravelApiResponse({
    required this.categories,
    required this.popularCities,
    required this.recommendedCities,
  });

  factory TravelApiResponse.fromJson(Map<String, dynamic> json) {
    return TravelApiResponse(
      categories: (json['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList(),
      popularCities: (json['popularCities'] as List)
          .map((city) => City.fromJson(city))
          .toList(),
      recommendedCities: (json['recommendedCities'] as List)
          .map((city) => City.fromJson(city))
          .toList(),
    );
  }
}

class Category {
  int id;
  String title;
  bool isSelected= false;

  Category({required this.id, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
    );
  }
}

class City {
  int id;
  String title;
  String image;
  String rating;

  City({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image, 'rating': rating};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
