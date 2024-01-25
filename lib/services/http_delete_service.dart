import 'dart:developer';

import 'package:http/http.dart' as http;

class DeleteApi {
  static Future<bool> deleteData({int? id}) async {
    try {
      final response = await http.delete(
          Uri.parse('https://gorest.co.in/public/v2/users/$id'),
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
