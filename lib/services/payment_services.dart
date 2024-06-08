import 'dart:convert';

import 'package:satupintu_app/model/doku_qris_model.dart';
import 'package:satupintu_app/model/doku_va_model.dart';
import 'package:satupintu_app/model/payment_qris_model.dart';
import 'package:satupintu_app/model/payment_va_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/firebase_notification_services.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/values.dart';

class PaymentServices {
  Future<DokuVaModel> getVaPayment(int tagihanId, PaymentVaModel data) async {
    try {
      final token = await AuthService().getToken();
      final notificationToken =
          await FirebaseNotificationServices().initNotification();

      final body = jsonEncode(
        {
          "tagihan_id": tagihanId,
          "request_id": data.requestId.toString(),
          "request_timestamp": getCurrentTimeFormatted(),
          "bank": data.bank.toString(),
          "payment_order": {
            "order": {
              "invoice_number": data.invoiceNumber.toString(),
              "amount": data.amount
            },
            "virtual_account_info": {
              "expired_time": data.expiredTime,
              "reusable_status": data.reusableStatus,
            },
            "customer": {
              "name": data.name.toString(),
              "email": data.email.toString()
            },
          },
          "fcm_token": notificationToken
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

  Future<DokuQrisModel> getQris(int tagihanId, PaymentQrisModel data) async {
    try {
      final token = await AuthService().getToken();

      final body = jsonEncode({
        "request_id": data.requestId,
        "tagihan_id": tagihanId,
        "request_timestamp": getCurrentTimeFormatted(),
        "order": {"amount": data.amount, "invoice_number": data.invoiceNumber},
        "payment": {
          "payment_due_date": data.paymentDueDate,
          "payment_method_types": [
            data.paymentMethodTypes,
            "QRIS",
          ]
        }
      });

      final res = await http.post(
        Uri.parse('$baseUrl/payments/qris-checkout'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: body,
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return DokuQrisModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DokuVaModel>> getAllVaPayment() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/payments/virtual-account/wajib-retribusi/$roleId/status/WAITING'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<DokuVaModel>.from(jsonDecode(res.body)['data']
          .map((va) => DokuVaModel.fromJson(va))).toList();
    } catch (e) {
      rethrow;
    }
  }
}
