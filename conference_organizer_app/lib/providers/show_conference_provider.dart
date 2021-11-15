import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> isSubscribed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logedPersonId = prefs.getString("personId");

    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(
      Uri.parse('$apiUrl/person-event/is-subscribed'),
      headers: headers,
      body:
          jsonEncode({"userId": logedPersonId, "eventId": eventId.toString()}),
    );

    if (res.statusCode != 200) return false;

    return true;
  }

  Future<void> subscribe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logedPersonId = prefs.getString("personId");

    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(
      Uri.parse('$apiUrl/person-event/subscribe'),
      headers: headers,
      body:
          jsonEncode({"userId": logedPersonId, "eventId": eventId.toString()}),
    );

    if (res.statusCode != 200) log("greska kod prijavljivanja na event");
  }

  Future<List<Map<String, dynamic>>?> getGradingSubjectOfConference() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(Uri.parse('$apiUrl/grading-subject/get-all'),
        headers: headers, body: _conferenceId.toString());

    log("session status " + res.statusCode.toString());

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }
}

class GradingSubject {
  late int _gradingSubjectId;
  late String _gradingSubjectName;
  late int _grade;

  GradingSubject();
  GradingSubject.value(
      int gradingSubjectId, String gradingSubjectName, int grade) {
    _gradingSubjectId = gradingSubjectId;
    _gradingSubjectName = gradingSubjectName;
    _grade = grade;
  }

  String get gradingSubjectName => _gradingSubjectName;

  setGrade(int g) {
    _grade = g;
  }
}
