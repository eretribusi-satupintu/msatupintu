class UserModel {
  final int? id;
  final int? role;
  final int? role_id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoProfile;
  final String? address;
  final String? nik;

  const UserModel({
    this.id,
    this.role,
    this.role_id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoProfile,
    this.address,
    this.nik,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        role: json['roles']['id'],
        role_id: json['role_id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        photoProfile: json['photo_profile'],
        address: json['alamat'],
        nik: json['nik'],
      );

  UserModel copyWith({
    String? email,
    String? phoneNumber,
    String? photoProfile,
    String? address,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoProfile: photoProfile ?? this.photoProfile,
      address: address ?? this.address,
      nik: nik,
    );
  }
}
