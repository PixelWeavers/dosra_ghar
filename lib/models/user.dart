class UserModel {
  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.hostelBlock,
      required this.messType,
      required this.accountType});
  // UserModel({required this.username, required this.password});
  final String? uid;
  final String? name;
  final String? email;
  final Hostel? hostelBlock;
  final Mess? messType;
  final AccountType? accountType;
}

enum Mess { veg, nonveg, special }

enum Hostel { blockA, blockB, blockC, blockD1, blockD2 }

enum AccountType { admin, student }
