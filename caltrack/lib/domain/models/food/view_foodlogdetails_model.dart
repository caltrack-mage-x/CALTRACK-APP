class FoodLogDetailsModel {
  final String logId;
  final String userName;
  final String foodName;
  final double quantity;
  final int totalCalories;
  final DateTime consumedAt;

  FoodLogDetailsModel({
    required this.logId,
    required this.userName,
    required this.foodName,
    required this.quantity,
    required this.totalCalories,
    required this.consumedAt,
  });

  factory FoodLogDetailsModel.fromJson(Map<String, dynamic> json) {
    return FoodLogDetailsModel(
      logId: json['log_id'],
      userName: json['user_name'],
      foodName: json['food_name'],
      quantity: json['quantity'],
      totalCalories: json['total_calories'],
      consumedAt: DateTime.parse(json['consumed_at']),
    );
  }
}
