import 'stadium_model.dart';
import 'users_model.dart';

class BookingModel {
  final String bookingId;
  final StadiumModel stadium;
  final UsersModel user;
  final DateTime startDateTime;
  final DateTime endDateTime;
  String status;

  BookingModel({
    required this.bookingId,
    required this.stadium,
    required this.user,
    required this.startDateTime,
    required this.endDateTime,
    this.status = 'Confirmed',
  });

  double calculateTotal() {
    var hours = endDateTime.difference(startDateTime).inHours;
    return hours * stadium.hourlyRate;
  }

  void cancelBooking() {
    status = 'Cancelled';
    stadium.updateStatus('Available');
  }
}
