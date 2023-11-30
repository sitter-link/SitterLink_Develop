class CreateRatingParam {
  final int bookingId;
  final double rating;
  final String comment;

  CreateRatingParam({
    required this.bookingId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      "rating": rating.toInt().toString(),
      "message": comment,
    };
  }
}
