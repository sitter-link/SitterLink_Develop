class PushNotification {
  String title;
  String message;
  String modelId;
  String type;

  PushNotification({
    required this.title,
    required this.message,
    required this.modelId,
    required this.type,
  });

  factory PushNotification.fromJson(Map json) {
    return PushNotification(
      title: json['title'] ?? "",
      message: json['body'] ?? "",
      modelId: json['entity_id'] ?? "",
      type: json['type'] ?? "",
    );
  }
}
