class PaymentMethod {
  String method;
  String image;
  String paymentMethod;

  PaymentMethod({
    required this.method,
    required this.image,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'method': method,
      'image': image,
      'payment_method': paymentMethod,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      method: map['method'],
      image: map['image'],
      paymentMethod: map['payment_method'],
    );
  }
}
