class TagihanModel {
  final int? id;
  final String? requestId;
  final String? invoiceNumber;
  final String? tagihanName;
  final String? dueDate;
  final String? udpatedDate;
  final String? status;
  final int? price;
  final String? paymentTime;
  final String? wajibRetribusiName;
  final String? email;
  final String? phoneNumber;
  final String? itemRetribusiName;
  final String? tagihanType;
  final String? retribusiName;
  final String? kedinasanName;

  TagihanModel(
      {this.id,
      this.requestId,
      this.invoiceNumber,
      this.tagihanName,
      this.dueDate,
      this.udpatedDate,
      this.status,
      this.price,
      this.wajibRetribusiName,
      this.email,
      this.phoneNumber,
      this.paymentTime,
      this.itemRetribusiName,
      this.tagihanType,
      this.retribusiName,
      this.kedinasanName});

  factory TagihanModel.fromJson(Map<String, dynamic> json) => TagihanModel(
        id: json['id'],
        requestId: json['request_id'],
        invoiceNumber: json['invoice_id'],
        tagihanName: json['nama'],
        dueDate: json['jatuh_tempo'],
        udpatedDate: json['updated_at'],
        status: json['status'],
        price: json['total_harga'],
        paymentTime: json['payment_time'],
        wajibRetribusiName: json['kontrak']['wajib_retribusi']['users']['name'],
        email: json['kontrak']['wajib_retribusi']['users']['email'],
        phoneNumber: json['kontrak']['wajib_retribusi']['users']
            ['phone_number'],
        itemRetribusiName: json['kontrak']['item_retribusi']['kategori_nama'],
        tagihanType: json['kontrak']['item_retribusi']['jenis_tagihan'],
        retribusiName: json['kontrak']['item_retribusi']['retribusi']['nama'],
        kedinasanName: json['kontrak']['item_retribusi']['retribusi']
            ['kedinasan']['nama'],
      );

  TagihanModel copyWith({String? status}) => TagihanModel(
        id: id,
        requestId: requestId,
        invoiceNumber: invoiceNumber,
        tagihanName: tagihanName,
        dueDate: dueDate,
        udpatedDate: udpatedDate,
        status: status ?? this.status,
        price: price,
        paymentTime: paymentTime,
        wajibRetribusiName: wajibRetribusiName,
        email: email,
        phoneNumber: phoneNumber,
        itemRetribusiName: itemRetribusiName,
        tagihanType: tagihanType,
        retribusiName: retribusiName,
        kedinasanName: kedinasanName,
      );

}
