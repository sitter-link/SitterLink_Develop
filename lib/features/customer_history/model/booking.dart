// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nanny_app/core/enum/booking_status.dart';
import 'package:nanny_app/core/model/commitment_type.dart';
import 'package:nanny_app/core/model/experience.dart';
import 'package:nanny_app/core/model/skill.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/customer_history/model/booking_date.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';

class Booking {
  final int id;
  final User user;
  final Nanny nanny;
  final List<Experience> careNeeded;
  final List<Skill> expectations;
  final String additionalMessage;
  final CommitmentType commitmentType;
  final BookingStatus status;
  final List<BookingDate> bookingDate;
  final bool hasBeenFavorite;
  final bool hasReviewed;
  final bool hasPaymentDone;
  final num totalAmount;

  Booking({
    required this.id,
    required this.user,
    required this.nanny,
    required this.careNeeded,
    required this.expectations,
    required this.additionalMessage,
    required this.commitmentType,
    required this.status,
    required this.bookingDate,
    required this.hasBeenFavorite,
    required this.hasPaymentDone,
    required this.hasReviewed,
    required this.totalAmount,
  });

  factory Booking.fromMap(Map<String, dynamic> map) {
    final List<BookingDate> dates = List.from(map['booking_dates'])
        .map<BookingDate>(
          (x) => BookingDate.fromMap(x),
        )
        .toList();
    dates.sort((a, b) => a.date.compareTo(b.date));
    return Booking(
      id: map['id'] as int,
      user: User.fromMap(map['parent']),
      nanny: Nanny.fromFavoriteApiMap(map['nanny']),
      careNeeded: List.from(map['care_needs'] ?? [])
          .map<Experience>(
            (x) => Experience.fromMap(x),
          )
          .toList(),
      expectations: List.from(map['expectations'] ?? [])
          .map<Skill>(
            (x) => Skill.fromMap(x),
          )
          .toList(),
      additionalMessage: map['additional_message'] ?? "",
      commitmentType: CommitmentType.fromMap(map['commitment']),
      status: BookingStatus.fromString(map['status']),
      bookingDate: dates,
      hasBeenFavorite: map['has_been_favorite'] ?? false,
      hasPaymentDone: map["has_payment_done"] ?? false,
      hasReviewed: map["has_reviewed"] ?? false,
      totalAmount: map["total_amount"] ?? 0,
    );
  }

  Booking copyWith({
    int? id,
    User? user,
    Nanny? nanny,
    List<Experience>? careNeeded,
    List<Skill>? expectations,
    String? additionalMessage,
    CommitmentType? commitmentType,
    BookingStatus? status,
    List<BookingDate>? bookingDate,
    bool? hasBeenFavorite,
    bool? hasReviewed,
    bool? hasPaymentDone,
  }) {
    return Booking(
      id: id ?? this.id,
      user: user ?? this.user,
      nanny: nanny ?? this.nanny,
      careNeeded: careNeeded ?? this.careNeeded,
      expectations: expectations ?? this.expectations,
      additionalMessage: additionalMessage ?? this.additionalMessage,
      commitmentType: commitmentType ?? this.commitmentType,
      status: status ?? this.status,
      bookingDate: bookingDate ?? this.bookingDate,
      hasBeenFavorite: hasBeenFavorite ?? this.hasBeenFavorite,
      hasPaymentDone: hasPaymentDone ?? this.hasPaymentDone,
      hasReviewed: hasReviewed ?? this.hasReviewed,
      totalAmount: totalAmount,
    );
  }
}
