enum BookingStatus {
  pending(value: "pending"),
  accepted(value: "accepted"),
  rejected(value: "rejected"),
  completed(value: "completed");

  final String value;
  const BookingStatus({required this.value});

  factory BookingStatus.fromString(String val) {
    if (val.toLowerCase() == BookingStatus.pending.value) {
      return BookingStatus.pending;
    } else if (val.toLowerCase() == BookingStatus.accepted.value) {
      return BookingStatus.accepted;
    } else if (val.toLowerCase() == BookingStatus.rejected.value) {
      return BookingStatus.rejected;
    } else if (val.toLowerCase() == BookingStatus.completed.value) {
      return BookingStatus.completed;
    } else {
      throw Exception("Invalid Booking status");
    }
  }
}
