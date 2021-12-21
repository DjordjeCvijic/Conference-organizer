import 'dart:developer';

import 'package:conference_organizer_app/providers/show_conference_provider.dart';
import 'package:conference_organizer_app/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ShowConferenceScreen extends StatelessWidget {
  const ShowConferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final conferenceId = args["conferenceId"] as int;
    return ChangeNotifierProvider.value(
      value: ShowConferenceProvider(),
      builder: (context, child) => Scaffold(
        body: FutureBuilder(
          future: Provider.of<ShowConferenceProvider>(context, listen: false)
              .getConferenceToShow(conferenceId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!["name"],
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  color: Colors.grey[800],
                                  height: 650,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Column(children: [
                                      const MyDivider("General data"),
                                      const SizedBox(
                                        height: 17,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text("Name:",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.white)),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  snapshot.data!["name"],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 55,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text("Description:",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.white)),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  snapshot.data!["description"],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 55,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text("Period:",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.white)),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  snapshot.data!["dateFrom"]
                                                          .toString()
                                                          .substring(0, 10) +
                                                      " - " +
                                                      snapshot.data!["dateTo"]
                                                          .toString()
                                                          .substring(0, 10),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 55,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text("Location:",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.white)),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  snapshot.data!["location"],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 55,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text("Creator:",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.white)),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  snapshot
                                                      .data!["creatorEmail"],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 55,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => ChangeNotifierProvider<
                                                        ShowConferenceProvider>.value(
                                                    value:
                                                        ShowConferenceProvider(),
                                                    child: AlertDialogForGrades(
                                                        conferenceId)));
                                          },
                                          child: const Text("Grade"))
                                    ]),
                                  ),
                                )),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.grey[800],
                                    height: 650,
                                    child: Column(
                                      children: [
                                        FutureBuilder(
                                            future: Provider.of<
                                                        ShowConferenceProvider>(
                                                    context,
                                                    listen: false)
                                                .getAllSessionsToShow(),
                                            builder: (context,
                                                    AsyncSnapshot<
                                                            List<
                                                                Map<String,
                                                                    dynamic>>?>
                                                        snapshot) =>
                                                snapshot.connectionState ==
                                                        ConnectionState.waiting
                                                    ? const CircularProgressIndicator()
                                                    : SessionBox(
                                                        snapshot.data!)),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Container(
                                  color: Colors.grey[800],
                                  height: 650,
                                  child: Consumer<ShowConferenceProvider>(
                                      builder:
                                          (context, provider, child) => Column(
                                                children: [
                                                  Provider.of<ShowConferenceProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .sessionId ==
                                                          0
                                                      ? const SizedBox.shrink()
                                                      : FutureBuilder(
                                                          future: Provider.of<
                                                                      ShowConferenceProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getAllEventsToShow(),
                                                          builder: (context,
                                                                  AsyncSnapshot<List<Map<String, dynamic>>?>
                                                                      snapshot) =>
                                                              snapshot.connectionState ==
                                                                      ConnectionState
                                                                          .waiting
                                                                  ? const CircularProgressIndicator()
                                                                  : EventBox(snapshot.data!))
                                                ],
                                              )),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class SessionBox extends StatefulWidget {
  List<Map<String, dynamic>> data;
  SessionBox(this.data, {Key? key}) : super(key: key);

  @override
  _SessionBoxState createState() => _SessionBoxState();
}

class _SessionBoxState extends State<SessionBox> {
  int selectedElement = 0;

  @override
  Widget build(BuildContext context) {
    var _showConferenceProvider =
        Provider.of<ShowConferenceProvider>(context, listen: false);
    //log(widget.data.first["sessionId"].toString());
    //_showConferenceProvider.setSessionId(widget.data.first["sessionId"]);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: _showConferenceProvider.sessionId == -1
          ? const Text("No sessions")
          : Column(
              children: [
                const MyDivider("Session"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedElement == index
                                    ? Colors.blue
                                    : Colors.blue[300],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.data[index]["name"],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          _showConferenceProvider.setSessionId(
                                              widget.data[index]["sessionId"]);
                                          setState(() {
                                            selectedElement = index;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.remove_red_eye_rounded)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyDivider("Session info"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("Name:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 21, color: Colors.white)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(widget.data[selectedElement]["name"],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("Description:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 21, color: Colors.white)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(widget.data[selectedElement]["description"],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("Moderator:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 21, color: Colors.white)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                            widget.data[selectedElement]["moderatorEmail"],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("Online:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 21, color: Colors.white)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(widget.data[selectedElement]["isOnline"],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                  ],
                ),
              ],
            ),
    );
  }
}

class EventBox extends StatefulWidget {
  List<Map<String, dynamic>> data;
  EventBox(this.data, {Key? key}) : super(key: key);

  @override
  _EventBoxState createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  int selectedElement = 0;

  get child => null;

  @override
  Widget build(BuildContext context) {
    var _showConferenceProvider =
        Provider.of<ShowConferenceProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: _showConferenceProvider.eventId == -1
          ? const MyDivider("No events")
          : Column(
              children: [
                const MyDivider("Events"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedElement == index
                                    ? Colors.blue
                                    : Colors.blue[300],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.data[index]["name"],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          _showConferenceProvider.setEventId(
                                              widget.data[index]["eventId"]);
                                          setState(() {
                                            selectedElement = index;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.remove_red_eye_rounded)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyDivider("Event info"),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 330,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Name:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]["name"],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Description:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]["description"],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Type:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]["eventType"],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Lecturer:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]
                                        ["lecturerEmail"]
                                    
                                    ,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Date:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]["date"]
                                        .toString()
                                        .substring(0, 10),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Time:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]["timeFrom"] +
                                        " - " +
                                        widget.data[selectedElement]["timeTo"],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text("Place:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    widget.data[selectedElement]["place"],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ],
                        ),
                        widget.data[selectedElement]["online"] != true
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 18,
                              ),
                        widget.data[selectedElement]["online"] != true
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Text("Access Link:",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 19, color: Colors.white)),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          widget.data[selectedElement]
                                              ["accessLink"],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white))),
                                ],
                              ),
                        widget.data[selectedElement]["online"] != true
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 18,
                              ),
                        widget.data[selectedElement]["online"] != true
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Text("Access Password:",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 19, color: Colors.white)),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          widget.data[selectedElement]
                                              ["accessPassword"],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white))),
                                ],
                              ),
                        const SizedBox(
                          height: 18,
                        ),
                        FutureBuilder(
                            future: _showConferenceProvider.isSubscribed(),
                            builder: (context, AsyncSnapshot<bool?> snapshot) =>
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const CircularProgressIndicator()
                                    : snapshot.data == true
                                        ? ElevatedButton(
                                            onPressed: () {
                                              _showConferenceProvider
                                                  .subscribe();
                                              setState(() {});
                                            },
                                            child: const Text("Unsubscribe"))
                                        : ElevatedButton(
                                            onPressed: () async {
                                              await _showConferenceProvider
                                                  .subscribe();
                                              setState(() {});
                                            },
                                            child: const Text("Subscribe")))
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class AlertDialogForGrades extends StatelessWidget {
  int conferenceId;
  AlertDialogForGrades(this.conferenceId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _showConferenceProvider =
        Provider.of<ShowConferenceProvider>(context, listen: false);
    return FutureBuilder(
        future: _showConferenceProvider.isGradingDone(conferenceId),
        builder: (context, AsyncSnapshot<bool?> snapshot) => snapshot
                    .connectionState ==
                ConnectionState.waiting
            ? const CircularProgressIndicator()
            : snapshot.data!
                ? AlertDialog(
                    title: const Text("Grading "),
                    content: SizedBox(
                        height: 400,
                        width: 450,
                        child: FutureBuilder(
                            future: _showConferenceProvider
                                .getGradesOfConference(conferenceId),
                            builder: (context,
                                    AsyncSnapshot<List<Map<String, dynamic>>?>
                                        snapshot) =>
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const CircularProgressIndicator()
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          String _gradingSubjectName =
                                              snapshot.data![index]
                                                  ["gradingSubjectName"];
                                          String _avaregeGrade = snapshot
                                              .data![index]["grade"]
                                              .toString();

                                          return Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    _gradingSubjectName,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    _avaregeGrade + "/5",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ))),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  )
                : AlertDialog(
                    title: const Text("Grading "),
                    content: SizedBox(
                        height: 400,
                        width: 450,
                        child: FutureBuilder(
                            future: _showConferenceProvider
                                .getGradingSubjectOfConferenceToGrade(
                                    conferenceId),
                            builder: (context,
                                    AsyncSnapshot<List<Map<String, dynamic>>?>
                                        snapshot) =>
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const CircularProgressIndicator()
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _showConferenceProvider
                                            .gradingSubjectList.length,
                                        itemBuilder: (context, index) {
                                          String _gradingSubjectName =
                                              _showConferenceProvider
                                                  .gradingSubjectList
                                                  .elementAt(index)
                                                  .gradingSubjectName;

                                          return Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    _gradingSubjectName,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                RatingBar.builder(
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                    itemSize: 20,
                                                    initialRating: 0,
                                                    direction: Axis.horizontal,
                                                    onRatingUpdate: (grade) {
                                                      _showConferenceProvider
                                                          .gradingSubjectList
                                                          .elementAt(index)
                                                          .setGrade(grade);
                                                      log("ocjena " +
                                                          int.parse(grade
                                                                  .toString())
                                                              .toString());
                                                    })
                                              ],
                                            ),
                                          );
                                        },
                                      ))),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _showConferenceProvider
                              .saveGrades()
                              .then((value) => Navigator.pop(context, 'OK'));
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
  }
}
