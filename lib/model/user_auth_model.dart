class UserAuthModel {
  final int? id;
  final int? role;
  final int? roleId;
  final String? nik;
  final String? name;
  final String? email;
  final String? password;
  final String? token;
  final int? pin;
  final int? subWilayahId;
  final String? profilePhotoUrl;

  UserAuthModel(
      {this.id,
      this.role,
      this.roleId,
      this.nik,
      this.name,
      this.email,
      this.password,
      this.token,
      this.pin,
      this.subWilayahId,
      this.profilePhotoUrl});

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
      id: json['id'],
      role: json['role_id'],
      roleId: json['role']['id'],
      nik: json['nik'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
      pin: json['pin'],
      subWilayahId: json['role']['subwilayah_id'],
      profilePhotoUrl: json['profile_photo_url']);

  UserAuthModel copyWith({String? email, String? password, int? pin}) =>
      UserAuthModel(
          id: id,
          role: role,
          roleId: roleId,
          nik: nik,
          name: name,
          email: email ?? this.email,
          password: password ?? this.password,
          token: token,
          pin: pin ?? this.pin,
          subWilayahId: subWilayahId);
}
