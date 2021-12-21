import 'dart:developer';

import 'package:flutter/material.dart';
import "../globals.dart" as globals;

class ConferenceCard extends StatelessWidget {
  final Map<String, dynamic>? data;
  const ConferenceCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
          height: 30,
          width: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(data!["name"],
                            style: Theme.of(context).textTheme.headline2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("  Place: ${data!["location"]}",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 10,
                ),
                Text("  From date: ${data!["dateFrom"]}  ",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 10,
                ),
                Text("  To date: ${data!["dateTo"]}",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Creator: ${data!["creatorEmail"]}  ",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ],
            ),
          )),
      onTap: () {
        log("stisno");
        Navigator.pushNamed(context, globals.showConferenceSccreeRoute,
            arguments: {
              "conferenceId": data!["conference_id"],
            });
      },
    );
  }
}
