class StadiumModel {
  final int stadiumId;
  final String sportType;
  final String location;
  final int? capacity;
  String status;
  final double hourlyRate;

  StadiumModel({
    required this.stadiumId,
    required this.sportType,
    required this.location,
    this.capacity,
    required this.status,
    required this.hourlyRate,
  });

  bool checkAvailability(DateTime start, DateTime end) {
    // تحقق وهمي placeholder
    return true;
  }

  void updateStatus(String newStatus) {
    status = newStatus;
  }
}
