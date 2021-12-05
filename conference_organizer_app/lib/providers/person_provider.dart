import 'package:flutter/material.dart';

import '../const.dart';

import 'package:http/http.dart' as http;

class PersonProvider extends ChangeNotifier {
  Future<bool> personExist(String email) async {
    var apiUrl = "${Constants.baseUrl}/person/exist";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: email,
    );

    if (res.statusCode != 200) return false;
    if (res.body == true.toString()) return true;
    return false;
  }
}
