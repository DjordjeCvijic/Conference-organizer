import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/providers/location_provider.dart';
import 'package:conference_organizer_app/providers/person_provider.dart';
import 'package:conference_organizer_app/providers/shared_preferences_service.dart';
import 'package:conference_organizer_app/providers/supervising_provider.dart';
import 'package:conference_organizer_app/screens/add_conference_sreen.dart';
import 'package:conference_organizer_app/screens/all_conference_screen.dart';
import 'package:conference_organizer_app/screens/supervising_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    1: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConferenceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PersonProvider(),
        )
      ],
      builder: (context, child) => const AddConferenceScreen(),
    ),
    2: ChangeNotifierProvider(
      create: (context) => SupervisingProvider(),
      child: const SupervisingScreen(),
    ),
  };

  final drawerItems = [
    DrawerItem("All conferences", Icons.menu_book_outlined),
    DrawerItem("Add conferences", Icons.add_circle_outlined),
    DrawerItem("Supervision", Icons.edit_outlined),
    DrawerItem("Log out", Icons.logout_outlined)
  ];

  _getDrawerItemScreen() {
    if (_selectedIndex == 3) {
      Navigator.pop(context);
      return null;
      // return listOfScreens.entries.elementAt(0).value;
    }

    return listOfScreens.entries.elementAt(_selectedIndex).value;
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  late SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

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
                              : const Text("No data"),
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
                              : const Text("No data"),
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
