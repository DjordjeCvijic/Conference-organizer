import 'package:conference_organizer_app/screens/add_conference_sreen.dart';
import 'package:conference_organizer_app/screens/all_conference_screen.dart';
import 'package:flutter/material.dart';

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
    0: const AllConferenceScreen(),
    1: const AddConferenceScreen()
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
            const UserAccountsDrawerHeader(
                accountName: Text(
                  "Yuvraj Pandey",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                accountEmail: Text(
                  "yuvrajn.pandey@gmail.com",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
