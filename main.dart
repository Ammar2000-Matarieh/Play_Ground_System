import 'controllers/system_controller.dart';
import 'models/stadium_model.dart';
import 'models/users_model.dart';

void main() {
  // Initialize controllers
  final systemController = SystemController();

  // Create sample data
  var user1 = UsersModel(userId: 1, name: 'Ahmad ', phoneNumber: 0799347273);
  var user2 = UsersModel(userId: 2, name: 'Mohammad', phoneNumber: 0799388873);
  var user3 = UsersModel(userId: 3, name: 'Sam', phoneNumber: 0799342343);
  var user4 = UsersModel(userId: 4, name: 'Zak', phoneNumber: 0799342133);

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
    sportType: 'BasketBoll',
    location: 'Irbid',
    capacity: 5,
    status: 'Available',
    hourlyRate: 40,
  );

  var stadium3 = StadiumModel(
    stadiumId: 30,
    sportType: 'Tines',
    location: 'Aqaba',
    capacity: 2,
    status: 'Busy',
    hourlyRate: 80,
  );

  // Make a booking
  try {
    var booking1 = systemController.createBooking(
      user: user1,
      stadium: stadium1,
      startDateTime: DateTime(2023, 12, 15, 16),
      endDateTime: DateTime(2023, 12, 15, 18),
    );
    var booking2 = systemController.createBooking(
      user: user2,
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

    // View user bookings
    var userBookings = systemController.getUserBookings(
      user1.userId.toString(),
    );
    print('User reservations: ${userBookings.length}');
  } catch (e) {
    print('حدث خطأ: ${e.toString()}');
  }
}
