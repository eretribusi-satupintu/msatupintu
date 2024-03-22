class PembayaranModel {
  final int? tagihanId;
  final String? paymentMethod;
  final String? name;
  final String? retributionItemName;
  final String? status;
  final String? date;
  final int? amount;
  // final String? bank;
  final String? createdAt;

  const PembayaranModel(
      {this.tagihanId,
      this.paymentMethod,
      this.name,
      this.retributionItemName,
      this.status,
      this.date,
      this.amount,
      // this.bank,
      this.createdAt});

  factory PembayaranModel.fromJson(Map<String, dynamic> json) =>
      PembayaranModel(
        tagihanId: json['tagihan_id'],
        paymentMethod: json['metode_pembayaran'],
        name: json['tagihan']['nama'],
        retributionItemName: json['tagihan']['kontrak']['item_retribusi']
            ['kategori_nama'],
        status: json['status'],
        date: json['created_at'],
        amount: json['tagihan']['total_harga'],
        // bank: json['VirtualAccount']['bank'],
        createdAt: json['created_at'],
      );
}
