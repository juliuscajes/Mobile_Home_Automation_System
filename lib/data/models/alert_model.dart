class AlertModel {
  final int alertId;
  final String message;
  final String type; // Usage Pattern, Threshold, Security
  final DateTime createdAt;
  bool acknowledged;

  AlertModel({
    required this.alertId,
    required this.message,
    required this.type,
    required this.createdAt,
    this.acknowledged = false,
  });
}
