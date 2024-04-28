class UserUpdateFormModel {
  final String? email;
  final String? phoneNumber;
  final String? photoProfile;
  final String? address;

  const UserUpdateFormModel(
    this.email,
    this.phoneNumber,
    this.address,
    this.photoProfile,
  );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "alamat": address,
      "phone_number": phoneNumber,
      "photo_profile": photoProfile
    };
  }
}
