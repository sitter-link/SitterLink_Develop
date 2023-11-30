class BookingDetails {
  String nannyName;
  String jobCommitment;
  DateTime startDate;
  num daysWorked;
  String hoursWorked;
  bool hasPaid;
  num hourlyRate;
  num totalAmount;

  BookingDetails({
    required this.nannyName,
    required this.jobCommitment,
    required this.startDate,
    required this.daysWorked,
    required this.hoursWorked,
    required this.hasPaid,
    required this.hourlyRate,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nanny_name': nannyName,
      'job_commitment': jobCommitment,
      'start_date': startDate.millisecondsSinceEpoch,
      'days_worked': daysWorked,
      'hours_worked': hoursWorked,
      'has_paid': hasPaid,
      'hourly_rate': hourlyRate,
      'total_amount': totalAmount,
    };
  }

  factory BookingDetails.fromMap(Map<String, dynamic> map) {
    return BookingDetails(
      nannyName: map['nanny_name'],
      jobCommitment: map['job_commitment'],
      startDate: DateTime.parse(map['start_date']),
      daysWorked: map['days_worked'],
      hoursWorked: map['hours_worked'],
      hasPaid: map['has_paid'],
      hourlyRate: map['hourly_rate'],
      totalAmount: map['total_amount'],
    );
  }
}
