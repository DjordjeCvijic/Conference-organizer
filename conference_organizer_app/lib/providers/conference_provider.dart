import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class ConferenceProvider extends ChangeNotifier {
  late String _dateFrom = "";
  late String _dateTo = "";

  ConferenceProvider();
  String get dateFrom => _dateFrom;

  String get dateTo => _dateTo;

  setDateFrom(String s) {
    _dateFrom = s;
  }

  setDateTo(String s) {
    _dateTo = s;
  }

  Future<List<Map<String, dynamic>>?> getAllConferences() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.get(
      Uri.parse('$apiUrl/conference/all'),
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }
}
