import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/providers/shared_preferences_service.dart';
import 'package:conference_organizer_app/screens/add_conference_sreen.dart';
import 'package:conference_organizer_app/screens/all_conference_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NavigationDrawerState();
  }
}

class NavigationDrawerState extends State<NavigationDrawer> {
  int _selectedIndex = 0;
  Map<int, dynamic> listOfScreens = {
    0: ChangeNotifierProvider(
      create: (context) => ConferenceProvider(),
      child: const AllConferenceScreen(),
    ),
    1: ChangeNotifierProvider(
      create: (constext) => ConferenceProvider(),
      child: const AddConferenceScreen(),
    )
    // 0: ChangeNotifierProvider(
    //   create: (context) => HomeProvider(),
    //   child: const HomeScreen(),
    // ),
    // 1: ChangeNotifierProvider(
    //   create: (context) => ContentProvider(),
    //   child: const SearchScreen(),
    // ),
    // 2: ChangeNotifierProvider.value(
    //   value: FavouritesProvider(),
    //   child: const FavoritesScreen(),
    // ),
    // 3: const SettingsScreen()
  };

  final drawerItems = [
    DrawerItem("All conferences", Icons.menu_book_outlined),
    DrawerItem("Add conferences", Icons.add_circle_outlined),
  ];

  _getDrawerItemScreen() {
    return listOfScreens.entries.elementAt(_selectedIndex).value;
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  late SharedPreferencesService sharedPreferencesService =
      new SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(
          d.title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conference Organizer'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: FutureBuilder(
                  future: sharedPreferencesService.getLogedUserName(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.data != null
                              ? Text(
                                  snapshot.data.toString(),
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                )
                              : const Text("nema podataka"),
                ),
                accountEmail: FutureBuilder(
                  future: sharedPreferencesService.getLogedUserEmail(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.data != null
                              ? Text(
                                  snapshot.data.toString(),
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                )
                              : const Text("nema podataka"),
                )),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemScreen(),
    );
  }
}

class DrawerItem {
  late String _title;
  late IconData _iconData;

  DrawerItem(String s, IconData localAirport) {
    _title = s;
    _iconData = localAirport;
  }

  IconData? get icon => _iconData;
  String get title => _title;
}
