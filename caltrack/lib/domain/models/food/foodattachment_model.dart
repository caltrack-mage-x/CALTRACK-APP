class FoodAttachmentModel {
  final String attachmentId;
  final String foodId;
  final String filePath;
  final DateTime uploadedAt;

  FoodAttachmentModel({
    required this.attachmentId,
    required this.foodId,
    required this.filePath,
    required this.uploadedAt,
  });

  factory FoodAttachmentModel.fromJson(Map<String, dynamic> json) {
    return FoodAttachmentModel(
      attachmentId: json['attachment_id'],
      foodId: json['food_id'],
      filePath: json['file_path'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attachment_id': attachmentId,
      'food_id': foodId,
      'file_path': filePath,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}
