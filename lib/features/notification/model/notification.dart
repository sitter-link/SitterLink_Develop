class AppNotification {
  final int id;
  final String title;
  final String description;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'],
      title: map['body']?['notification']?['title'] ?? "",
      description: map['body']?['notification']?['body'] ?? "",
    );
  }
}
