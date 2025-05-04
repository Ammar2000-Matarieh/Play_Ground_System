// يمثل نوع الرياضة وقواعدها :
class SportsModel {
  final String sportType;
  final int maxBookingDurationInHours;
  final int playersCount;

  SportsModel({
    required this.sportType,
    required this.maxBookingDurationInHours,
    required this.playersCount,
  });

  bool validateBookingRules(Duration duration) {
    return duration.inHours <= maxBookingDurationInHours;
  }
}
