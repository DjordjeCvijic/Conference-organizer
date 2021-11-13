import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class ShowConferenceProvider extends ChangeNotifier {
  late int _conferenceId;
  int _sessionId = -1;
  late int _eventId = -1; //-1 ostaje ako nema eventova

  int get sessionId => _sessionId;
  int get eventId => _eventId;

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

    setSessionId(-1); //samo da resetujem
    if (resList.isNotEmpty) {
      setSessionId(resList[0]["sessionId"]);
    }

    // _sessionId = resList[0]["sessionId"];
    return resList;
  }

  Future<List<Map<String, dynamic>>?> getAllEventsToShow() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(Uri.parse('$apiUrl/event/all-to-show'),
        headers: headers, body: _sessionId.toString());

    log("session status " + res.statusCode.toString());

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    _eventId = -1; //samo da resetujem
    if (resList.isNotEmpty) {
      _eventId = resList[0]["eventId"];
    }
    //setSessionId(resList[0]["sessionId"]);
    // _sessionId = resList[0]["sessionId"];
    return resList;
  }

  void setSessionId(int id) {
    _sessionId = id;
    notifyListeners();
  }

  void setEventId(int id) {
    _eventId = id;
  }
}
