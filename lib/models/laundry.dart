class LaundryModel {
  LaundryModel(
      {required this.noClothes,
      required this.token,
      required this.isCheckIn,
      required this.date,
      required this.uid})
      : isDay = false;
  final bool isDay;
  final String noClothes;
  final String token;
  final bool isCheckIn;
  final DateTime date;
  final String uid;
}
