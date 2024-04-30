class TagihanLocalAmountModel {
  final List<int>? tagihanLocalId;
  final int? amount;

  const TagihanLocalAmountModel({this.tagihanLocalId, this.amount});

  Map<String, dynamic> toJson() {
    return {
      "tagihan_local_id": tagihanLocalId,
      "amount": amount,
    };
  }
}
