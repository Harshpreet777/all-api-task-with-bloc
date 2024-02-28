import 'dart:developer';

import 'package:bloc_api_task/models/request_model.dart';
import 'package:http/http.dart' as http;

class PostData {
  static Future<bool> postData(RequestModel requestModel) async {
    try {
      final response = await http.post(
          Uri.parse('https://gorest.co.in/public/v2/users'),
          body: requestModelToJson(requestModel),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
          });

      if (response.statusCode == 201) {
        // log("response.body is ${response.body}");
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
