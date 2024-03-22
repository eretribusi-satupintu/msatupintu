class PaymentVaModel {
  final String? requestId;
  final String? bank;
  final String? invoiceNumber;
  final double? amount;
  final int? expiredTime;
  final bool? reusableStatus;
  final String? info1;
  final String? name;
  final String? email;

  const PaymentVaModel({
    this.requestId,
    this.bank,
    this.invoiceNumber,
    this.amount,
    this.expiredTime,
    this.reusableStatus,
    this.info1,
    this.name,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'bank': bank,
      'invoice_number': invoiceNumber,
      'amount': amount,
      'expired_time': expiredTime,
      'reusable_status': reusableStatus,
      'info1': info1,
      'name': name,
      'email': email,
    };
  }

  // factory PaymentVaModel.fromJson(Map<String, dynamic> json) => PaymentVaModel(
  //       requestId: json['request_id'],
  //       bank: json['bank'],
  //       invoiceNumber: json['invoice_number'],
  //       amount: json['amount'],
  //       expiredTime: json['expired_time'],
  //       reusableStatus: json['reusable_status'],
  //       info1: json['info1'],
  //       name: json['name'],
  //       email: json['email'],
  //     );
}
