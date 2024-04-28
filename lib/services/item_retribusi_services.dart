import 'dart:convert';

import 'package:satupintu_app/model/item_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/shared/values.dart';

class ItemRetribusiServices {
  Future<List<ItemRetribusiModel>> getItemRetribusi() async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http
          .get(Uri.parse('$baseUrl/item-retribusi/${subWilayah.id}'), headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });

      print(jsonDecode(res.body)['data']);

      if (res.statusCode != 200) {
        return jsonDecode(res.body)['message'];
      }

      return List<ItemRetribusiModel>.from(jsonDecode(res.body)['data'].map(
              (itemRetribusi) => ItemRetribusiModel.fromJson(itemRetribusi)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
