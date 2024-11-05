class User {
  final String? token;
  final String name;
  final String email;
  final String? photo;
  final String role;

  User({
    required this.name,
    required this.email,
    this.photo,
    required this.role,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      name: json['data']['name'],
      email: json['data']['email'],
      photo: json['data']['photo'],
      role: json['data']['role'],
    );
  }
}