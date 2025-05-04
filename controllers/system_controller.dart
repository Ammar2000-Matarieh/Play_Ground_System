import '../models/booking_model.dart';
import '../models/payment_model.dart';
import '../models/stadium_model.dart';
import '../models/users_model.dart';

// ادارة عمليات الحجز والدفع والاستعلامات :
class SystemController {
  final List<BookingModel> bookingsItems = [];
  final List<Payment> _payments = [];

  // Create New Booking :
  BookingModel createBooking({
    required UsersModel user,
    required StadiumModel stadium,
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) {
    // Check Validate Date Time :
    if (startDateTime.isAfter(endDateTime)) {
      print("Start date must be before end date");
    }

    // التحقق من توفر الملعب
    if (!stadium.checkAvailability(startDateTime, endDateTime)) {
      throw Exception('الملعب غير متاح في هذا الموعد');
    }

    // التحقق من عدم وجود تعارض في الحجوزات
    if (_hasBookingConflict(
      stadium.stadiumId.toString(),
      startDateTime,
      endDateTime,
    )) {
      throw Exception('هناك حجز آخر في هذا الموعد');
    }

    final booking = BookingModel(
      bookingId: 'book_${DateTime.now().millisecondsSinceEpoch}',
      stadium: stadium,
      user: user,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );

    bookingsItems.add(booking);
    stadium.updateStatus('Booked');

    return booking;
  }

  // معالجة الدفع
  Payment processPayment({
    required BookingModel booking,
    required double amount,
    required String method,
  }) {
    if (amount != booking.calculateTotal()) {
      throw Exception('المبلغ غير مطابق لتكلفة الحجز');
    }

    final payment = Payment(
      paymentId: 'pay_${DateTime.now().millisecondsSinceEpoch}',
      booking: booking,
      amount: amount,
      method: method,
      date: DateTime.now(),
    );

    _payments.add(payment);
    return payment;
  }

  // الحصول على حجوزات المستخدم
  List<BookingModel> getUserBookings(int userId) {
    // تغيير المعامل إلى int بدلاً من String
    return bookingsItems.where((b) => b.user.userId == userId).toList();
  }

  // إلغاء الحجز
  void cancelBooking(String bookingId) {
    final booking = bookingsItems.firstWhere((b) => b.bookingId == bookingId);
    booking.cancelBooking();
  }

  // التحقق من تعارض الحجوزات (دالة مساعدة)
  bool _hasBookingConflict(String stadiumId, DateTime start, DateTime end) {
    return bookingsItems.any((booking) {
      return booking.stadium.stadiumId == stadiumId &&
          !(end.isBefore(booking.startDateTime) ||
              start.isAfter(booking.endDateTime));
    });
  }
}
