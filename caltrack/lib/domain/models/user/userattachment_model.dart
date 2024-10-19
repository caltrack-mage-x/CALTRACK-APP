class UserAttachmentModel {
  final String attachmentId;
  final String userId;
  final String filePath;
  final String fileType;
  final DateTime uploadedAt;

  UserAttachmentModel({
    required this.attachmentId,
    required this.userId,
    required this.filePath,
    required this.fileType,
    required this.uploadedAt,
  });

  factory UserAttachmentModel.fromJson(Map<String, dynamic> json) {
    return UserAttachmentModel(
      attachmentId: json['attachment_id'],
      userId: json['user_id'],
      filePath: json['file_path'],
      fileType: json['file_type'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attachment_id': attachmentId,
      'user_id': userId,
      'file_path': filePath,
      'file_type': fileType,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}
