import 'dart:developer';

import 'package:conference_organizer_app/providers/session_editing_provider.dart';
import 'package:provider/provider.dart';

import "../globals.dart" as globals;
import 'package:flutter/material.dart';

class SessionEventCard extends StatelessWidget {
  final Map<String, dynamic>? data;
  const SessionEventCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: SessionEditingProvider(),
        builder: (context, child) => InkWell(
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
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text("U sklopu ${data!["partOfName"]}",
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    ),
                  )),
              onTap: () {
                if (data!["type"] == "session") {
                  Provider.of<SessionEditingProvider>(context, listen: false)
                      .getSessionToEdit(data!["id"])
                      .then((value) {
                    if (value!) {
                      Navigator.pushNamed(
                          context, globals.sessionEditingScreenRout,
                          arguments: {
                            "sessionId": data!["id"],
                            "name": data!["name"],
                            "description": data!["description"]
                          });
                    }
                  });
                } else {
                  log("ovo ce se izvrsiti kad ase klikne na editovanje veneta " +
                      data!["type"]);
                }
                log("ovdje se radi " + data!["type"]);
              },
            ));
  }
}
