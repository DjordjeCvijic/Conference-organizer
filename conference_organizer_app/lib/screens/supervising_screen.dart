import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/providers/supervising_provider.dart';
import 'package:conference_organizer_app/widgets/session_event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_conference_screen.dart';

class SupervisingScreen extends StatefulWidget {
  const SupervisingScreen({Key? key}) : super(key: key);

  @override
  _SupervisingScreenState createState() => _SupervisingScreenState();
}

class _SupervisingScreenState extends State<SupervisingScreen> {
  var chosenTab = 0;
  @override
  Widget build(BuildContext context) {
    final supervisingProvider = Provider.of<SupervisingProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 300,
              child: CustomTabElevatedButton(
                tabTitle: "Sessions",
                active: chosenTab == 0,
                onTap: () {
                  if (chosenTab != 0) {
                    setState(
                      () {
                        chosenTab = 0;
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: CustomTabElevatedButton(
                tabTitle: "Events",
                active: chosenTab == 1,
                onTap: () {
                  if (chosenTab != 1) {
                    setState(
                      () {
                        chosenTab = 1;
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        // Text(
        //   "All conferences:",
        //   style: Theme.of(context).textTheme.headline3,
        // ),
        FutureBuilder(
            future: supervisingProvider.getSessionsAndEvents(chosenTab),
            builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
                            child: GridView.count(
                              shrinkWrap: true,
                              primary: false,
                              // padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 25,
                              crossAxisCount: 6,
                              children:
                                  List.generate(snapshot.data!.length, (index) {
                                return Container(
                                    child: SessionEventCard(
                                        snapshot.data![index]));
                              }),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Nema podataka,",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )),
      ],
    );
  }
}
