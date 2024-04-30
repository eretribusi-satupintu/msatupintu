class TagihanLocalModel {
  final int? id;
  final int? tagihanId;
  final int? subWilayahId;
  final String? tagihanName;
  final String? wajibRetribusiName;
  final int? price;
  final String? subwilayah;
  final String? dueDate;
  final bool? status;

  const TagihanLocalModel({
    this.id,
    this.tagihanId,
    this.subWilayahId,
    this.tagihanName,
    this.wajibRetribusiName,
    this.price,
    this.subwilayah,
    this.dueDate,
    this.status,
  });

  factory TagihanLocalModel.fromJson(Map<String, dynamic> json) =>
      TagihanLocalModel(
        tagihanId: json['id'],
        subWilayahId: json['kontrak']['sub_wilayah']['id'],
        tagihanName: json['nama'],
        wajibRetribusiName: json['kontrak']['wajib_retribusi']['users']['name'],
        price: json['total_harga'],
        subwilayah: json['kontrak']['sub_wilayah']['nama'],
        dueDate: json['jatuh_tempo'],
        status: json['status'] == 'NEW' ? false : true,
      );

  // TagihanModel copyWith({String? status}) => TagihanModel(
  //       id: id,
  //       requestId: requestId,
  //       invoiceNumber: invoiceNumber,
  //       tagihanName: tagihanName,
  //       dueDate: dueDate,
  //       udpatedDate: udpatedDate,
  //       status: status ?? this.status,
  //       price: price,
  //       paymentTime: paymentTime,
  //       wajibRetribusiName: wajibRetribusiName,
  //       email: email,
  //       phoneNumber: phoneNumber,
  //       itemRetribusiName: itemRetribusiName,
  //       tagihanType: tagihanType,
  //       retribusiName: retribusiName,
  //       kedinasanName: kedinasanName,
  //     );

  factory TagihanLocalModel.fromDatabaseJson(Map<String, dynamic> data) =>
      TagihanLocalModel(
        id: data['id'],
        tagihanId: data['tagihan_id'],
        subWilayahId: data['subwilayah_id'],
        tagihanName: data['tagihan_name'],
        wajibRetribusiName: data['wajib_retribusi_name'],
        price: data['price'],
        subwilayah: data['subwilayah'],
        dueDate: data['due_date'],
        status: data['status'] == 0 ? false : true,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'tagihan_id': tagihanId,
        'sub_wilayah_id': subWilayahId,
        'tagihan_name': tagihanName,
        'wajib_retribusi_name': wajibRetribusiName,
        'price': price,
        'subwilayah': subwilayah,
        'due_date': dueDate,
        'status': status == false ? 0 : 1,
      };
}
