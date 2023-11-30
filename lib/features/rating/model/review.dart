import 'package:nanny_app/features/auth/model/user.dart';

class Review {
  final int id;
  final int bookingId;
  final User user;
  final int rating;
  final String message;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.bookingId,
    required this.user,
    required this.rating,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'booking': bookingId,
      'user': user.toMap(),
      'rating': rating,
      'message': message,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      bookingId: map['booking'],
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      rating: num.parse(map['rating']).toInt(),
      message: map['message'] as String,
      createdAt: DateTime.parse(map['created_at']).toLocal(),
    );
  }
}
