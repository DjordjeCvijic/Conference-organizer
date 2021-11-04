import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../const.dart';

class SessionEditingProvider extends ChangeNotifier {
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
    return true;
  }
}

class SessionToEdit {
  late int _sessionId;
  late String _name = "";
  late String _description = "";

  late final List<Event> _eventList = [];

  int get sessionId => _sessionId;
  String get name => _name;
  String get description => _description;
  List<Event> get eventList => _eventList;

  setSessionId(int i) {
    _sessionId = i;
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
}

class Event {
  late int _eventId;
  late int _sessonId;
  late String _eventType;
  late String _moderatorEmail = "";
  late String _place;
  late int placeId;
  late String _name = "";
  late String _description = "";
  late String _dateAndTimeFrom = "";
  late String _dateAndTimeTo = "";
}
