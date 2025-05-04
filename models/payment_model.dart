import 'booking_model.dart';

class Payment {
  final String paymentId;
  final BookingModel booking;
  final double amount;
  final String method;
  final DateTime date;

  Payment({
    required this.paymentId,
    required this.booking,
    required this.amount,
    required this.method,
    required this.date,
  });
}
