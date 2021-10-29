import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> login(String email, String password) async {
    var apiUrl = "${Constants.baseUrl}/person/login";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    print(jsonEncode({
      "email": email,
      "password": password,
    }));

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (res.statusCode != 200) return false;
    var tmp = (jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("personId", tmp["personId"].toString());
    prefs.setString("firstName", tmp["firstName"].toString());
    prefs.setString("lastName", tmp["lastName"].toString());
    prefs.setString("email", tmp["email"].toString());
    return true;
  }

  Future<bool> registration(
      String firstName, String lastName, String email, String pass) async {
    var apiUrl = "${Constants.baseUrl}/person/registration";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": pass
      }),
    );

    if (res.statusCode != 200) return false;
    return true;
  }
}
