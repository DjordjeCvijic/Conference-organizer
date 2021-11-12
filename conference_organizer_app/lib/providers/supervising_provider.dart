import 'dart:convert';
import 'dart:developer';

import 'package:conference_organizer_app/providers/session_editing_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';

class SupervisingProvider extends ChangeNotifier {
  EventToEdit eventToEdit = EventToEdit();
  late Resource selectedResource;
  List<Resource> resourceList = [];

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

  Future<bool> getEventToEdit(int eventId) async {
    var apiUrl = "${Constants.baseUrl}/event/get-by-id";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: eventId.toString(),
    );

    if (res.statusCode != 200) return false;

    var resList =
        (jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>);

    eventToEdit.setEventId(resList["eventId"]);
    eventToEdit.setName(resList["name"]);
    eventToEdit.setDescription(resList["description"]);
    eventToEdit.setLecturerEmail(resList["lecturerEmail"]);
    eventToEdit.setIsOnline(resList["isOnline"]);
    eventToEdit.setAccessLink(resList["accessLink"]);
    eventToEdit.setAccessPassword(resList["accessPassword"]);

    print(resList.toString());
    eventToEdit._resourcesIdList.clear();
    for (var i = 0; i < (resList['resourceIdList'] as List).length; i++) {
      log("usao u for");
      // eventToEdit
      //     .addResourceId(int.parse((resList['resourceIdList'] as List)[i]));
      eventToEdit.addResourceId((resList['resourceIdList'] as List)[i]);
    }
    log("izasao for");
    print("resursi " + eventToEdit.resourcesIdList.toString());

    await getResourceAll();
    return true;
  }

  Future<bool> saveEvent() async {
    var apiUrl = "${Constants.baseUrl}/event/save";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    final params = {
      "accessLink": eventToEdit.accessLink,
      "accessPassword": eventToEdit._accessPassword,
      "description": eventToEdit.description,
      "eventId": eventToEdit.eventId,
      "isOnline": eventToEdit.isOnline,
      "lecturerEmail": eventToEdit.lecturerEmail,
      "name": eventToEdit.name,
      "resourceIdList": eventToEdit._resourcesIdList,
    };
    print(params);
    print(jsonEncode(params));
    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(params),
    );

    log("res status " + res.statusCode.toString());
    if (res.statusCode != 200) return false;

    log(eventToEdit.name +
        "" +
        eventToEdit.description +
        " " +
        eventToEdit.lecturerEmail);
    log(eventToEdit.resourcesIdList.toString());

    return true;
  }

  Future<bool> isEventOnline() async {
    return eventToEdit._isOnline;
  }

  Future<List<Map<String, dynamic>>?> getResourceAll() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res =
        await http.get(Uri.parse('$apiUrl/resource/get-all'), headers: headers);

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    resourceList.clear();

    for (int i = 0; i < resList.length; i++) {
      resourceList
          .add(Resource.value(resList[i]["resourceId"], resList[i]["name"]));
    }

    log("pozvano dohvatanje resursa i " + resList.length.toString());
    return resList;
  }

  String getResourceName(int id) {
    String res = "";
    for (int i = 0; i < resourceList.length; i++) {
      if (resourceList[i]._id == id) {
        res = resourceList[i]._name;
      }
    }
    return res;
  }
}

class EventToEdit {
  int _eventId = 0;
  String _name = "";
  String _description = "";
  String _lecturerEmail = "";
  bool _isOnline = false;
  String _accessLink = "";
  String _accessPassword = "";

  final List<int> _resourcesIdList = [];

  EventToEdit();
  EventToEdit.value(
      this._eventId,
      this._name,
      this._description,
      this._lecturerEmail,
      this._isOnline,
      this._accessLink,
      this._accessPassword);

  int get eventId => _eventId;
  String get name => _name;
  String get description => _description;
  String get lecturerEmail => _lecturerEmail;
  bool get isOnline => _isOnline;
  String get accessLink => _accessLink;
  String get accessPassword => _accessPassword;

  List<int> get resourcesIdList => _resourcesIdList;

  void setEventId(int id) {
    _eventId = id;
  }

  void setName(String name) {
    _name = name;
  }

  void setDescription(String desc) {
    _description = desc;
  }

  void setLecturerEmail(String email) {
    _lecturerEmail = email;
  }

  void setIsOnline(bool tmp) {
    _isOnline = tmp;
  }

  void setAccessLink(String link) {
    _accessLink = link;
  }

  void setAccessPassword(String pass) {
    _accessPassword = pass;
  }

  void addResourceId(int id) {
    _resourcesIdList.add(id);
  }

  void removeResourceId(int id) {
    _resourcesIdList.remove(id);
  }
}

class Resource {
  late int _id;
  late String _name;

  Resource() {
    _id = 0;
  }
  Resource.value(int id, String name) {
    _id = id;
    _name = name;
  }

  int get id => _id;
  String get name => _name;
}
