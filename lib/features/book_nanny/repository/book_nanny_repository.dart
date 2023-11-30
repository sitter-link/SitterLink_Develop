import 'package:dartz/dartz.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/features/book_nanny/model/book_a_nanny_param.dart';
import 'package:nanny_app/features/book_nanny/model/create_payment_param.dart';
import 'package:nanny_app/features/book_nanny/model/update_booking_status_param.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';
import 'package:nanny_app/features/customer_history/model/booking_details.dart';
import 'package:nanny_app/features/customer_history/model/create_rating_param.dart';
import 'package:nanny_app/features/customer_history/model/payment_method.dart';

class BookNannyRepository {
  final ApiProvider apiProvider;
  final Env env;

  BookNannyRepository({
    required this.apiProvider,
    required this.env,
  });

  final List<Booking> _customerHistory = [];
  List<Booking> get customerHistory => _customerHistory;

  Future<Either<String, void>> bookNanny(BookANannyParam param) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/booking/user/${param.nannyId}/create",
        param.toMap(),
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Booking>>> fetchCustomerBookingHistory(
      {String? fullName}) async {
    try {
      final Map<String, dynamic> query = {};

      if (fullName != null) {
        query["fullname"] = fullName;
      }

      final res = await apiProvider.get(
        "${env.baseUrl}/booking/history",
        queryParams: query,
      );
      final items =
          List.from(res["data"]).map((e) => Booking.fromMap(e)).toList();
      _customerHistory.clear();
      _customerHistory.addAll(items);
      return Right(_customerHistory);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Booking>>> fetchNannyPendingBooking() async {
    try {
      final res = await apiProvider.get("${env.baseUrl}/booking/list/booking");
      final items =
          List.from(res["data"]).map((e) => Booking.fromMap(e)).toList();
      return Right(items);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UpdateBookingStatusParam>> updateBookingStatus(
      UpdateBookingStatusParam param) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/booking/${param.bookingId}/accept-reject",
        {
          "status": param.status.value,
        },
      );
      return Right(param);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> cancelBooking(int bookingId) async {
    try {
      final _ = await apiProvider
          .delete("${env.baseUrl}/booking/$bookingId/cancel-booking");
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, BookingDetails>> fetchBookingDetails(
      int bookingId) async {
    try {
      final res = await apiProvider
          .get("${env.baseUrl}/payment/booking/$bookingId/detail");
      List<Map<String, dynamic>> temp = List.from(res["data"]);
      if (temp.isEmpty) {
        return const Left("Booking Details not found");
      } else {
        final details = BookingDetails.fromMap(temp.first);
        return Right(details);
      }
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<PaymentMethod>>> fetchPaymentMethods() async {
    try {
      final res = await apiProvider.get("${env.baseUrl}/payment/methods");
      final temp =
          List.from(res["data"]).map((e) => PaymentMethod.fromMap(e)).toList();
      return Right(temp);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> createPayment(CreatePaymentParam param) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/payment/booking/${param.bookingId}/create",
        param.toMap(),
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> createReview(CreateRatingParam param) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/booking/${param.bookingId}/review-add",
        param.toMap(),
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> paymentRequest(int bookingId) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/payment/booking/$bookingId/request-payment",
        {},
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
