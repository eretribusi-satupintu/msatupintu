class LoginFormModel {
  final int? role;
  final String? email;
  final String? password;

  LoginFormModel({this.role, this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'email': email,
      'password': password,
    };
  }
}
