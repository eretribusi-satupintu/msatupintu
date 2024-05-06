class DokuVaModel {
  final int? id;
  final int? tagihanId;
  final String? bank;
  final String? virtualAccountNumber;
  final int? amount;
  final String? createdDate;
  final String? expiredDate;
  final String? howToPayPage;
  final String? howToPayApi;

  DokuVaModel({
    this.id,
    this.tagihanId,
    this.bank,
    this.virtualAccountNumber,
    this.amount,
    this.howToPayPage,
    this.howToPayApi,
    this.createdDate,
    this.expiredDate,
  });

  factory DokuVaModel.fromJson(Map<String, dynamic> json) => DokuVaModel(
        id: json['id'],
        tagihanId: json['tagihan_id'],
        bank: json['bank'],
        virtualAccountNumber: json['virtual_account_number'],
        amount: json['harga'],
        howToPayPage: json['how_to_pay_page'],
        howToPayApi: json['how_to_pay_api'],
        createdDate: json['created_date'],
        expiredDate: json['expired_date'],
      );

  // DokuVaModel copyWith() => DokuVaModel(
  //       invoiceNumber: invoiceNumber,
  //       virtualAccountNumber: virtualAccountNumber,
  //       howToPayPage: howToPayPage,
  //       howToPayApi: howToPayApi,
  //       createdDate: createdDate,
  //       expiredDate: expiredDate,
  //     );
}
