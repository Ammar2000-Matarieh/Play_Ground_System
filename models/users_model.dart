import 'booking_model.dart';

class UsersModel {
  final int userId;
  final String name;
  final int phoneNumber;

  UsersModel({
    required this.userId,
    required this.name,
    required this.phoneNumber,
  });

  void viewBookings() {
    // عرض حجوزات المستخدم
  }

  void makeBooking(BookingModel booking) {
    // إنشاء حجز جديد
  }
}
