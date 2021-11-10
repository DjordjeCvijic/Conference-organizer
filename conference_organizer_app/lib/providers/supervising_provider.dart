import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';

class SupervisingProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>?> getSessionsAndEvents(int type) async {
    log("tab" + type.toString());
    var apiUrl = Constants.baseUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? creatorEmail = prefs.getString("email");

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(
        Uri.parse('$apiUrl/person/get-sessions-events-for-supervision'),
        headers: headers,
        body: creatorEmail);

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    log("duzina " + resList.length.toString());

    if (type == 0) {
      for (var i = 0; i < resList.length; i++) {
        if (resList[i]['type'] != "session") {
          resList.removeAt(i); //izbaci sve sto nije sesija
          i--;
        }
      }
    } else {
      for (var i = 0; i < resList.length; i++) {
        if (resList[i]['type'] != "event") {
          resList.removeAt(i);
          i--;
        }
      }
    }

    return resList;
  }

  // Future<bool> getEventToEdit(int eventId){

  // }
}

class EventToEdit {
  final int _eventId;
  final String _name;
  final String _description;
  final String _lecturerEmail;
  final bool _isOnline;
  final String _accessLink;
  final String _accessPassword;

  final List<int> _resourcesIdList = [];

  EventToEdit(this._eventId, this._name, this._description, this._lecturerEmail,
      this._isOnline, this._accessLink, this._accessPassword);

  int get eventId => _eventId;
  String get name => _name;
  String get description => _description;
  String get lecturerEmail => _lecturerEmail;
  bool get isOnline => _isOnline;
  String get accessLink => _accessLink;
  String get accessPassword => _accessPassword;

  List<int> get getResourcesIdList => _resourcesIdList;
}
