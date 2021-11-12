import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class ShowConferenceProvider extends ChangeNotifier {
  late int _conferenceId;
  late int _sessionId;

  Future<Map<String, dynamic>?> getConferenceToShow(int conferenceId) async {
    log(conferenceId.toString());
    _conferenceId = conferenceId;
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(
      Uri.parse('$apiUrl/conference/all-to-show'),
      headers: headers,
      body: conferenceId.toString(),
    );
    log(res.statusCode.toString());
    if (res.statusCode != 200) return null;

    var resList =
        (jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>);

    return resList;
  }

  Future<List<Map<String, dynamic>>?> getAllSessionsToShow() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(Uri.parse('$apiUrl/session/all-to-show'),
        headers: headers, body: _conferenceId.toString());

    log("session status " + res.statusCode.toString());

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    _sessionId = resList[0]["sessionId"];
    return resList;
  }

  void setSessionId(int id) {
    _sessionId = id;
  }
}
