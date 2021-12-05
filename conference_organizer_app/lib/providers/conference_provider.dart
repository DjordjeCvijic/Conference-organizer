import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';

class ConferenceProvider extends ChangeNotifier {
  ConferenceToSave conferenceToSave = ConferenceToSave();

  Future<List<Map<String, dynamic>>?> getAllConferences(int type) async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };
    http.Response res;
    List<Map<String, dynamic>> resList;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logedUserId = prefs.getString("personId");

    if (type == 2) {
      res = await http.post(
          Uri.parse('$apiUrl/conference/get-conferences-subscribed-to'),
          headers: headers,
          body: logedUserId);

      if (res.statusCode != 200) return null;

      resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      // if (type == 1) {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   String? logedEmail = prefs.getString("email");
      //   for (var i = 0; i < resList.length; i++) {
      //     if (resList[i]['creatorEmail'] != logedEmail) {
      //       resList.removeAt(i);
      //       i--;
      //     }
      //   }
      // }

    } else {
      res = await http.get(
        Uri.parse('$apiUrl/conference/all'),
        headers: headers,
      );

      if (res.statusCode != 200) return null;

      resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      if (type == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? logedEmail = prefs.getString("email");
        for (var i = 0; i < resList.length; i++) {
          if (resList[i]['creatorEmail'] != logedEmail) {
            resList.removeAt(i);
            i--;
          }
        }
      }
    }

    return resList;
  }

  Future<bool> saveConference() async {
    var apiUrl = "${Constants.baseUrl}/conference/add";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final params = {
      "creatorId": int.parse(prefs.getString("personId")!),
      "dateFrom": conferenceToSave.dateFrom,
      "dateTo": conferenceToSave.dateTo,
      "description": conferenceToSave.description,
      "locationId": conferenceToSave.locationId,
      "name": conferenceToSave.name,
      "gradingSubjectList": conferenceToSave.gradingSubject,
      "sessionRequestDtoList": conferenceToSave.session
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(params),
    );

    log("res status " + res.statusCode.toString());
    if (res.statusCode != 200) return false;
    return true;
  }
}

class ConferenceToSave {
  late int _creatorId = 0;
  late String _name = "";
  late String _description = "";
  late String _dateFrom = "";
  late String _dateTo = "";
  late int _locationId = 0;

  late final List<String> _gradingSubjects = [];
  late final List<Session> _sessions = [];

  String get dateFrom => _dateFrom;

  String get dateTo => _dateTo;

  int get locationId => _locationId;
  int get creatorId => _creatorId;

  String get name => _name;
  String get description => _description;

  List<String> get gradingSubject => _gradingSubjects;
  List<Session> get session => _sessions;

  setDateFrom(String s) {
    _dateFrom = s;
  }

  setDateTo(String s) {
    _dateTo = s;
  }

  setName(String s) {
    _name = s;
  }

  setDescription(String s) {
    _description = s;
  }

  setLocationId(int i) {
    _locationId = i;
  }

  setCreatorId(int i) {
    _creatorId = i;
  }

  addGradingSubject(String s) {
    _gradingSubjects.add(s);
  }

  removeGradingSubject(String s) {
    _gradingSubjects.remove(s);
  }

  addSession(Session s) {
    log(s._isOnline.toString());
    session.add(s);
  }

  removeSession(Session s) {
    _sessions.remove(s);
  }
}

class Session {
  late String _moderatorEmail = "";
  late String _name = "";
  late String _description = "";
  late bool _isOnline = false;

  Session();
  Session.value(String mail, String name, String d, bool online) {
    _moderatorEmail = mail;
    _name = name;
    _description = d;
    _isOnline = online;
  }

  String get moderatorEmail => _moderatorEmail;
  String get name => _name;
  String get description => _description;
  bool get isOnline {
    return _isOnline;
  }

  setModeratorEmail(String s) {
    _moderatorEmail = s;
  }

  setName(String s) {
    _name = s;
  }

  setDescription(String s) {
    _description = s;
  }

  setOnline(bool b) {
    _isOnline = b;
  }

  Map toJson() => {
        "description": _description,
        "moderatorEmail": _moderatorEmail,
        "name": name,
        "online": isOnline.toString()
      };
}
