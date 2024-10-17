class XPLogModel {
  final String xpLogId;
  final String userId;
  final int xpEarned;
  final DateTime logDate;

  XPLogModel({
    required this.xpLogId,
    required this.userId,
    required this.xpEarned,
    required this.logDate,
  });

  factory XPLogModel.fromJson(Map<String, dynamic> json) {
    return XPLogModel(
      xpLogId: json['xp_log_id'],
      userId: json['user_id'],
      xpEarned: json['xp_earned'],
      logDate: DateTime.parse(json['log_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xp_log_id': xpLogId,
      'user_id': userId,
      'xp_earned': xpEarned,
      'log_date': logDate.toIso8601String(),
    };
  }
}
