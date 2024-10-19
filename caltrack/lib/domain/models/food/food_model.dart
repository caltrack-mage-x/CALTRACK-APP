class FoodModel {
  final String foodId;
  final String name;
  final int calories;
  final double protein;
  final double fats;
  final double carbohydrates;
  final String? servingSize;
  final String? imageUrl;

  FoodModel({
    required this.foodId,
    required this.name,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbohydrates,
    this.servingSize,
    this.imageUrl,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodId: json['food_id'],
      name: json['name'],
      calories: json['calories'],
      protein: json['protein'],
      fats: json['fats'],
      carbohydrates: json['carbohydrates'],
      servingSize: json['serving_size'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'name': name,
      'calories': calories,
      'protein': protein,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'serving_size': servingSize,
      'image_url': imageUrl,
    };
  }
}
