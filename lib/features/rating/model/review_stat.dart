class ReviewStat {
  final int totalCount;
  final List<IndividualReview> individualReview;

  ReviewStat({
    required this.totalCount,
    required this.individualReview,
  });

  factory ReviewStat.fromMap(Map<String, dynamic> map) {
    return ReviewStat(
      totalCount: map['total_reviews'] ?? 0,
      individualReview: List.from(map['individual_review'] ?? [])
          .map((x) => IndividualReview.fromMap(x))
          .toList(),
    );
  }
}

class IndividualReview {
  final String rating;
  final int count;

  IndividualReview({
    required this.rating,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'count': count,
    };
  }

  factory IndividualReview.fromMap(Map<String, dynamic> map) {
    return IndividualReview(
      rating: map['rating'],
      count: map['count'],
    );
  }
}
