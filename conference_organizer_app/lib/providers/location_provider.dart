import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../const.dart';

class LocationProvider extends ChangeNotifier {
  late List<Location> listForDropDown;

  Future<bool> getAllLocations() async {
    var apiUrl = Constants.baseUrl;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
    };
    var res = await http.get(
      Uri.parse('$apiUrl/location/all'),
      headers: headers,
    );
    if (res.statusCode != 200) return false;

    var tmp = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    listForDropDown = tmp
        .map((m) => Location(m["locationId"], m["name"], m["address"]))
        .toList();

    return true;
  }
}

class Location {
  final int id;
  final String name;
  final String address;

  Location(this.id, this.name, this.address);
}
