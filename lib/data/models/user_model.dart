class UserModel {
  final String email;
  final String token;
  final String userName;

  UserModel({
    required this.email,
    required this.token,
    required this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      token: json['token'],
      userName: json['userName'], // 👈 parse it
    );
  }
}
