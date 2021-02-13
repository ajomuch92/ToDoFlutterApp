class User {
  String email, name, password;

  User({this.email, this.name, this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json['email'],
    name: json['name'],
    password: json['password']
  );
}