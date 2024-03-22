class TagihanModel {
  final int? kontrakId;
  final String? nama;
  final String? invoiceNumber;
  final String? requestId;
  final String? totalHarga;
  final String? status;
  final String? name;
  final String? email;
  final String? dueDate;

  TagihanModel(
      {this.invoiceNumber,
      this.requestId,
      this.kontrakId,
      this.nama,
      this.totalHarga,
      this.status,
      this.name,
      this.email,
      this.dueDate});

  factory TagihanModel.fromJson(Map<String, dynamic> json) => TagihanModel(
      kontrakId: json['kontrak_id'],
      invoiceNumber: json['invoice_number'],
      requestId: json['request_id'],
      nama: json['nama'],
      totalHarga: json['total_harga'].toString(),
      status: json['status'],
      name: json['name'],
      email: json['email'],
      dueDate: json['jatuh_tempo']);
}
