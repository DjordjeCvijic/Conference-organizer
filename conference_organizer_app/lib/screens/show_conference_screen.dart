import 'package:conference_organizer_app/providers/show_conference_provider.dart';
import 'package:conference_organizer_app/widgets/my_divider.dart';
import 'package:flutter/material.dart';
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
          future: Provider.of<ShowConferenceProvider>(context)
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
                                      const MyDivider("Opsti podaci"),
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
                                                  snapshot.data!["dateFrom"] +
                                                      " - " +
                                                      snapshot.data!["dateTo"],
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
                                      )
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
                                      children: const [
                                        MyDivider("Sessions"),
                                        SessionBox(),
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
  const SessionBox({Key? key}) : super(key: key);

  @override
  _SessionBoxState createState() => _SessionBoxState();
}

class _SessionBoxState extends State<SessionBox> {
  int selectedElement = 0;

  @override
  Widget build(BuildContext context) {
    var _showConferenceProvider =
        Provider.of<ShowConferenceProvider>(context, listen: false);
    return FutureBuilder(
        future: _showConferenceProvider.getAllSessionsToShow(),
        builder: (context,
                AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        // height: 50,
                        child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 3),
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
                                          child: Text(
                                              snapshot.data![index]["name"]),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                _showConferenceProvider
                                                    .setSessionId(
                                                        snapshot.data![index]
                                                            ["sessionId"]);
                                                setState(() {
                                                  selectedElement = index;
                                                });
                                              },
                                              icon: const Icon(Icons
                                                  .remove_red_eye_rounded)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                    )
                  ]));
  }
}
