import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  saveLogeUser(
      String id, String firstName, String lastName, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("personId", id);
    prefs.setString("firstName", firstName);
    prefs.setString("lastName", lastName);
    prefs.setString("email", email);
  }

  getLogedUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("firstName")! + " " + prefs.getString("lastName")!;
  }

  getLogedUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email")!;
  }
}
