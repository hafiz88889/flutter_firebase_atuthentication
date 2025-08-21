// user_model.dart
class UserModel {
  final String email;
  final String password;
  final DateTime? createdAt;

  UserModel({
    required this.email,
    required this.password,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      createdAt: map['createdAt']?.toDate(),
    );
  }
}
