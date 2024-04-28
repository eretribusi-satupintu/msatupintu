class DokuQrisModel {
  final int? id;
  final int? tagihanId;
  final String? paymentMethodTypes;
  final int? paymentDueDate;
  final String? url;
  final String? expiredDate;
  final String? uuid;
  final String? tokenId;

  const DokuQrisModel({
    this.id,
    this.tagihanId,
    this.paymentMethodTypes,
    this.paymentDueDate,
    this.url,
    this.expiredDate,
    this.uuid,
    this.tokenId,
  });

  factory DokuQrisModel.fromJson(Map<String, dynamic> json) => DokuQrisModel(
        id: json['id'],
        tagihanId: json['tagihanId'],
        paymentMethodTypes: json['payment_method_types'],
        paymentDueDate: json['payment_due_date'],
        url: json['url'],
        expiredDate: json['expired_date'],
        uuid: json['uuid'],
        tokenId: json['token_id'],
      );
}
