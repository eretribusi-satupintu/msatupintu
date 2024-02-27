class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? token;
  final int? pin;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
    this.pin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        token: json['token'],
        pin: json['pin'],
      );

  UserModel copyWith({String? email, String? password, int? pin}) => UserModel(
        id: id,
        name: name,
        email: email ?? this.email,
        password: password ?? this.password,
        token: token,
        pin: pin ?? this.pin,
      );
}
