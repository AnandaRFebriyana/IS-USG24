class User {
  final String? token;
  final String? name;
  final String? email;
  final String? photo;
  final String? role;

  User({
    this.token,
    this.name,
    this.email,
    this.photo,
    this.role
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      name: json['data']['name'],
      email: json['data']['email'],
      photo: json['data']['photo'],
      role: json['data']['role']
    );
  }
}