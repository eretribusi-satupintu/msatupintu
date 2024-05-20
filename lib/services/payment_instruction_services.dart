import 'dart:convert';

import 'package:satupintu_app/model/payment_instruction_model.dart';
import 'package:http/http.dart' as http;

class PaymentInstructionServices {
  Future<List<PaymentInstructionModel>> getPaymentInstruction(
      String url) async {
    try {
      final res = await http.get(Uri.parse(url));

      if (res.contentLength == null ||
          jsonDecode(res.body)['virtual_account_info']['status'] == 'PAID' ||
          jsonDecode(res.body)['virtual_account_info']['status'] == 'EXPIRED') {
        throw "Terjadi Kesalahan atau masa pembayaran telah berakhir";
      }

      return List<PaymentInstructionModel>.from(
          jsonDecode(res.body)['payment_instruction'].map((instruction) =>
              PaymentInstructionModel.fromJson(instruction))).toList();
    } catch (e) {
      rethrow;
    }
  }
}
