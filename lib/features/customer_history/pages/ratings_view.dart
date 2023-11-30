import 'package:flutter/material.dart';
import 'package:nanny_app/features/customer_history/widgets/ratings_body.dart';

class RatingsView extends StatelessWidget {
  final int bookingId;
  const RatingsView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return RatingsBody(bookingId: bookingId);
  }
}
