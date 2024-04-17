class SubWilayahModel {
  final int? id;
  final String? name;

  const SubWilayahModel({this.id, this.name});

  factory SubWilayahModel.fromJson(Map<String, dynamic> json) =>
      SubWilayahModel(
        id: json['id'],
        name: json['nama'],
      );
}
