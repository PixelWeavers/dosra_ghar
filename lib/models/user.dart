class UserModel {
  UserModel(
      {required this.uid,
      required this.name,
      required this.regNo,
      required this.email,
      required this.hostelBlock,
      required this.messType,
      required this.profileUrl,
      required this.accountType});
  // UserModel({required this.username, required this.password});
  final String? uid;
  final String? name;
  final String? regNo;
  final String? email;
  final String? hostelBlock;
  final String? messType;
  final String? accountType;
  final String? profileUrl;

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'regNo': regNo,
      'email': email,
      'hostel': hostelBlock,
      'mess': messType,
      'account_type': accountType,
      'profileUrl': profileUrl
      // Add any other fields you need
    };
  }
}
