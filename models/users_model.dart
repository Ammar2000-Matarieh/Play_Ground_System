import '../controllers/system_controller.dart';
import 'booking_model.dart';
import 'stadium_model.dart';

// file is Users :
class UsersModel {
  final int userId;
  final String name;
  final int phoneNumber;
  final SystemController systemController;

  UsersModel({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.systemController,
  });

  // عرض حجوزات المستخدم الحالي
  List<BookingModel> viewBookings() {
    return systemController.getUserBookings(this.userId);
  }

  // إنشاء حجز جديد
  BookingModel makeBooking({
    required StadiumModel stadium,
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) {
    return systemController.createBooking(
      user: this, // نستخدم this لأن UsersModel هو المستخدم الحالي
      stadium: stadium,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
  }
}
