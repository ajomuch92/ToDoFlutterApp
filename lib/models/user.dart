class User {
  String email, name, password, uuid, token;

  User({this.email, this.name, this.password, this.uuid, this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json['email'],
    name: json['name'],
    password: json['password'],
    uuid: json['uuid'],
    token: json['token']
  );

   Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'uuid': uuid
  };
   
   Map<String, dynamic> toCustomJson() => {
    'email': email,
    'name': name,
    'uuid': uuid,
    'token': token
  };
}