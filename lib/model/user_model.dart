class UserModel {
  final int? id; // Consider making essential fields required
  final String? name;
  final String? email;
  final String? phoneNumber; // Changed to String
  final String? photoProfile;
  final String? nik;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoProfile,
    this.nik,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        photoProfile: json['photo_profile'],
        nik: json['nik'],
      );

  UserModel copyWith({
    String? email,
    String? phoneNumber,
    String? photoProfile,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoProfile: photoProfile ?? this.photoProfile,
      nik: nik,
    );
  }
}
