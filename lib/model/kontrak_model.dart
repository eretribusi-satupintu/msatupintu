import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/model/tagihan_model.dart';

class KontrakModel {
  final int? id;
  final String? govermentName;
  final String? govermentLogo;

  const KontrakModel({
    this.id,
    this.govermentName,
    this.govermentLogo,
  });

  // factory KontrakModel.fromJson(Map<String, dynamic> json) => KontrakModel(
  //   id: json['id'],
  //   retributionName: json[''],
  // );
}
