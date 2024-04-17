import 'dart:convert';

import 'package:satupintu_app/model/doku_va_model.dart';
import 'package:satupintu_app/model/payment_va_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class PaymentServices {
  Future<DokuVaModel> getVaPayment(int tagihanId, PaymentVaModel data) async {
    try {
      final token = await AuthService().getToken();
      final body = jsonEncode(
        {
          "tagihan_id": tagihanId,
          "request_id": data.requestId.toString(),
          "bank": data.bank.toString(),
          "payment_order": {
            "order": {
              "invoice_number": data.invoiceNumber.toString(),
              "amount": data.amount
            },
            "virtual_account_info": {
              "expired_time": data.expiredTime,
              "reusable_status": data.reusableStatus,
              "info1": data.info1.toString()
            },
            "customer": {
              "name": data.name.toString(),
              "email": data.email.toString()
            }
          }
        },
      );

      final res = await http.post(Uri.parse('$baseUrl/payment/virtual-account'),
          headers: {'Content-Type': 'application/json', 'Authorization': token},
          body: body);

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      DokuVaModel payment = DokuVaModel.fromJson(jsonDecode(res.body)['data']);

      return payment;
    } catch (e) {
      rethrow;
    }
  }
}