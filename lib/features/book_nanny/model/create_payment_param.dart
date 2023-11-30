class CreatePaymentParam {
  final int bookingId;
  final String method;
  final String name;
  final num amount;

  CreatePaymentParam({
    required this.bookingId,
    required this.method,
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "method": method,
    };
  }
}
