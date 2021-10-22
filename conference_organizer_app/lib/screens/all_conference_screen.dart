import 'dart:js';

import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/screens/test_screen.dart';
import 'package:conference_organizer_app/widgets/conference_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllConferenceScreen extends StatelessWidget {
  AllConferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conferenceProvider = Provider.of<ConferenceProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          "All conferences:",
          style: Theme.of(context).textTheme.headline3,
        ),
        FutureBuilder(
            future: conferenceProvider.getAllConferences(),
            builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(100, 50, 100, 0),
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
                                    child:
                                        ConferenceCard(snapshot.data![index]));
                              }),
                            ),
                          )
                        : Center(
                            child: Text(
                              "localization.no_fav_data,",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )),
      ],
    );
  }
}
