class User{
  String email;
  String userName;
  String password;

  User({this.email, this.userName, this.password});

  Map<String, dynamic> toJson() => {
    'username' : userName,
    'email': email,
    'password': password
  };

  User.fromJson(Map<String, dynamic> json)
      : userName = json['username'],
        email = json['email'],
        password = json['password'];

}