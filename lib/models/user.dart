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
  final String? hostelBlock;
  final String? messType;
  final String? accountType;

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'hostel': hostelBlock,
      'mess': messType,
      'account_type': accountType,
      // Add any other fields you need
    };
  }
}
