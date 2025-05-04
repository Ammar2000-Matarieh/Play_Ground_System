import 'controllers/system_controller.dart';
import 'models/stadium_model.dart';
import 'models/users_model.dart';

void main() {
  // Initialize controllers
  final systemController = SystemController();

  // Create sample data
  var user1 = UsersModel(
    userId: 1,
    name: 'Ahmad',
    phoneNumber: 0799347273,
    systemController: systemController,
  );

  var user2 = UsersModel(
    userId: 2,
    name: 'Mohammad',
    phoneNumber: 0799388873,
    systemController: systemController,
  );

  var stadium1 = StadiumModel(
    stadiumId: 10,
    sportType: 'Football',
    location: 'Amman',
    capacity: 11,
    status: 'Available',
    hourlyRate: 30,
  );

  var stadium2 = StadiumModel(
    stadiumId: 20,
    sportType: 'Basketball',
    location: 'Irbid',
    capacity: 5,
    status: 'Available',
    hourlyRate: 40,
  );

  // Make a booking
  try {
    var booking1 = user1.makeBooking(
      stadium: stadium1,
      startDateTime: DateTime(2023, 12, 15, 16),
      endDateTime: DateTime(2023, 12, 15, 18),
    );

    var booking2 = user2.makeBooking(
      stadium: stadium2,
      startDateTime: DateTime(2023, 12, 15, 16),
      endDateTime: DateTime(2023, 12, 15, 18),
    );

    print('Reservation created successfully: ${booking1.bookingId}');
    print('Reservation created successfully: ${booking2.bookingId}');
    print('Total Cost: ${booking1.calculateTotal()} JD');
    print('Total Cost: ${booking2.calculateTotal()} JD');

    // Process payment
    var payment1 = systemController.processPayment(
      booking: booking1,
      amount: booking1.calculateTotal(),
      method: 'VISA',
    );

    var payment2 = systemController.processPayment(
      booking: booking2,
      amount: booking2.calculateTotal(),
      method: 'CASH',
    );

    print('Payment completed successfully: ${payment1.paymentId}');
    print('Payment completed successfully: ${payment2.paymentId}');

    // Debug: Print all bookings in system
    print('\nجميع الحجوزات في النظام:');
    systemController.bookingsItems.forEach((b) {
      print('''
      الحجز ID: ${b.bookingId}
      المستخدم: ${b.user.name} (ID: ${b.user.userId})
      الملعب: ${b.stadium.sportType}
      الحالة: ${b.status}
      ''');
    });

    // View user bookings
    var user1Bookings = user1.viewBookings();
    print('\nحجوزات أحمد (ID: ${user1.userId}): ${user1Bookings.length}');
    user1Bookings.forEach((b) {
      print('''
      رقم الحجز: ${b.bookingId}
      الملعب: ${b.stadium.sportType}
      المدة: ${b.endDateTime.difference(b.startDateTime).inHours} ساعات
      السعر: ${b.calculateTotal()} JD
      ''');
    });
  } catch (e) {
    print('حدث خطأ: ${e.toString()}');
  }
}
