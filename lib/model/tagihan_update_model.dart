class TagihanUpdateModel {
  final String? message;
  final String? status;

  const TagihanUpdateModel({this.message, this.status});

  factory TagihanUpdateModel.fromJson(Map<String, dynamic> json) =>
      TagihanUpdateModel(message: json['message'], status: json['status']);
}
