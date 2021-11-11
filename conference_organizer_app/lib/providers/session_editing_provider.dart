import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../const.dart';

class SessionEditingProvider extends ChangeNotifier {
  late List<EventType> eventTypeList = [];
  late List<Place> placeList = [];
  // late EventToAdd=new EV
  SessionToEdit sessionToEdit = SessionToEdit();

  Future<bool?> getSessionToEdit(int sessionId) async {
    var apiUrl = "${Constants.baseUrl}/session/get-session-to-edit";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: sessionId.toString(),
    );

    if (res.statusCode != 200) return false;

    var resList =
        (jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>);

    sessionToEdit.setSessionId(resList["sessionId"]);
    sessionToEdit.setName(resList["name"]);
    sessionToEdit.setDescription(resList["description"]);
    sessionToEdit.setLocationId(resList["locationId"]);

    print(resList.toString());

    for (var i = 0; i < (resList['eventList'] as List).length; i++) {
      sessionToEdit.addEvent(Event.valueWithId(
          (resList['eventList'] as List)[i]['eventId'],
          "",
          (resList['eventList'] as List)[i]['eventTypeId'],
          (resList['eventList'] as List)[i]['moderatorEmail'],
          "",
          (resList['eventList'] as List)[i]['placeId'],
          (resList['eventList'] as List)[i]['name'],
          (resList['eventList'] as List)[i]['description'],
          (resList['eventList'] as List)[i]['date'],
          (resList['eventList'] as List)[i]['timeFrom'],
          (resList['eventList'] as List)[i]['timeTo']));
    }

    return true;
  }

  Future<bool> saveSession() async {
    var apiUrl = "${Constants.baseUrl}/session/add";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    final params = {
      "name": sessionToEdit.name,
      "description": sessionToEdit.description,
      "locationId": sessionToEdit.locationId,
      "sessionId": sessionToEdit.sessionId,
      "eventList": sessionToEdit.eventList
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

    return true;
  }

  Future<bool> getAllEventTypes() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };
    var res = await http.get(
      Uri.parse('$apiUrl/event-type/all'),
      headers: headers,
    );
    if (res.statusCode != 200) return false;

    var tmp = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    eventTypeList =
        tmp.map((m) => EventType(m["eventTypeId"], m["name"])).toList();

    return true;
  }

  Future<bool> getAllPlacesForLocation() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };

    var res = await http.post(Uri.parse('$apiUrl/place/all-on-location'),
        headers: headers, body: sessionToEdit.locationId.toString());
    if (res.statusCode != 200) return false;

    var tmp = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    placeList = tmp
        .map((m) => Place(m["placeId"], m["name"], m["locationId"]))
        .toList();

    log("duzina liste" + placeList.length.toString());

    return true;
  }
}

class SessionToEdit {
  late int _sessionId;
  late String _name = "";
  late String _description = "";
  late int _locationId;

  late final List<Event> _eventList = [];

  int get sessionId => _sessionId;
  int get locationId => _locationId;
  String get name => _name;
  String get description => _description;
  List<Event> get eventList => _eventList;

  setSessionId(int i) {
    _sessionId = i;
  }

  setLocationId(int i) {
    _locationId = i;
  }

  setName(String s) {
    _name = s;
  }

  setDescription(String s) {
    _description = s;
  }

  addEvent(Event e) {
    _eventList.add(e);
  }

  removeEvent(Event e) {
    _eventList.remove(e);
  }
}

class Event {
  late int _eventId = 0;
  late int _sessonId = 0;
  late int _eventTypeId = 0;
  late String _moderatorEmail = "";
  late int _placeId = 0;
  late String _name = "";
  late String _description = "";
  late String _date = "";
  late String _timeFrom = "";
  late String _timeTo = "";

  Event();
  Event.value(
      String eventType,
      int eventTypeId,
      String moderatorEmal,
      String place,
      int placeId,
      String name,
      String desc,
      String date,
      String timeFrom,
      String timeTo) {
    _eventId = 0;
    _moderatorEmail = moderatorEmal;
    _placeId = placeId;
    _name = name;
    _description = desc;
    _date = date;
    _timeFrom = timeFrom;
    _timeTo = timeTo;
    _eventTypeId = eventTypeId;
  }
  Event.valueWithId(
      int eventId,
      String eventType,
      int eventTypeId,
      String moderatorEmal,
      String place,
      int placeId,
      String name,
      String desc,
      String date,
      String timeFrom,
      String timeTo) {
    _eventId = eventId;
    _moderatorEmail = moderatorEmal;
    _placeId = placeId;
    _name = name;
    _description = desc;
    _date = date;
    _timeFrom = timeFrom;
    _timeTo = timeTo;
    _eventTypeId = eventTypeId;
  }

  int get eventId => _eventId;
  String get moderatorEmail => _moderatorEmail;
  int get sessonId => _sessonId;
  int get placeId => _placeId;
  String get name => _name;
  String get description => _description;
  String get date => _date;
  String get timeFrom => _timeFrom;
  String get timeTo => _timeTo;
  int get eventTypeId => _eventTypeId;

  void setEventTypeId(int i) {
    _eventTypeId = i;
  }

  void setplaceId(int i) {
    _placeId = i;
  }

  void setName(String s) {
    _name = s;
  }

  void setDescription(String s) {
    _description = s;
  }

  void setModeratorEmail(String s) {
    _moderatorEmail = s;
  }

  void setDate(String d) {
    _date = d;
  }

  void setTimeFrom(String d) {
    _timeFrom = d;
  }

  void setTimeto(String d) {
    _timeTo = d;
  }

  Map toJson() => {
        "date": _date,
        "description": _description,
        "eventId": _eventId,
        "eventTypeId": _eventTypeId,
        "moderatorEmail": _moderatorEmail,
        "name": _name,
        "placeId": _placeId,
        "sessionId": _sessonId,
        "timeFrom": _timeFrom,
        "timeTo": _timeTo
      };
}

class EventType {
  final int eventTypeId;
  final String name;

  EventType(this.eventTypeId, this.name);
}

class Place {
  final int placeId;
  final String name;
  final int locationId;

  Place(this.placeId, this.name, this.locationId);
}
