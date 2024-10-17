class FoodLogModel {
  final String logId;
  final String userId;
  final String foodId;
  final DateTime consumedAt;
  final double quantity;
  final int totalCalories;

  FoodLogModel({
    required this.logId,
    required this.userId,
    required this.foodId,
    required this.consumedAt,
    required this.quantity,
    required this.totalCalories,
  });

  factory FoodLogModel.fromJson(Map<String, dynamic> json) {
    return FoodLogModel(
      logId: json['log_id'],
      userId: json['user_id'],
      foodId: json['food_id'],
      consumedAt: DateTime.parse(json['consumed_at']),
      quantity: json['quantity'],
      totalCalories: json['total_calories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'log_id': logId,
      'user_id': userId,
      'food_id': foodId,
      'consumed_at': consumedAt.toIso8601String(),
      'quantity': quantity,
      'total_calories': totalCalories,
    };
  }
}
