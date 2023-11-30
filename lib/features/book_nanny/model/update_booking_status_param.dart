import 'package:nanny_app/core/enum/booking_status.dart';
import 'package:nanny_app/features/customer_history/model/booking_date.dart';

class UpdateBookingStatusParam {
  final int bookingId;
  final String name;
  final List<BookingDate> bookingDates;
  final BookingStatus status;

  UpdateBookingStatusParam({
    required this.bookingId,
    required this.name,
    required this.bookingDates,
    required this.status,
  });
}
