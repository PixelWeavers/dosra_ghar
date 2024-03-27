class UserModel {
  UserModel(
      {required this.name,
      required this.email,
      required this.hostelBlock,
      required this.messType,
      required this.accountType})
      : role = accountType == AccountType.admin ? 'warden' : 'student';
  // UserModel({required this.username, required this.password});
  final String name;
  final String email;
  final Hostel hostelBlock;
  final Mess messType;
  final AccountType accountType;
  final String role;
}

enum Mess { veg, nonveg, special }

enum Hostel { blockA, blockB, blockC, blockD1, blockD2 }

enum AccountType { admin, student }
