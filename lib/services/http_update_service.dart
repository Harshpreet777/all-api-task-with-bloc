import 'dart:developer';

import 'package:bloc_api_task/models/request_model.dart';
import 'package:http/http.dart' as http;

class UpdateApi {
  static Future<bool> updateData(RequestModel requestModel, int id) async {
    try {
      final response = await http.put(
          Uri.parse('https://gorest.co.in/public/v2/users/$id'),
          body: requestModelToJson(requestModel),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
          });
      if (response.statusCode == 200) {
        log("response.data is ${response.body}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }
}
