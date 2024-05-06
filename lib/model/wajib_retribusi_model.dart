class WajibRetribusiModel {
  final int? id;
  final String? name;
  final String? nik;
  final String? noTelepon;
  final String? photoProfil;
  final int? jumlahTagihan;

  const WajibRetribusiModel(
      {this.id,
      this.name,
      this.nik,
      this.noTelepon,
      this.photoProfil,
      this.jumlahTagihan});

  factory WajibRetribusiModel.fromJson(Map<String, dynamic> json) =>
      WajibRetribusiModel(
        id: json['id'],
        name: json['name'],
        nik: json['nik'] ?? '-',
        noTelepon: json['no_telepon'] ?? '-',
        photoProfil: json['photo_profile'] ?? '-',
        jumlahTagihan: json['jumlah_tagihan'],
      );
}
