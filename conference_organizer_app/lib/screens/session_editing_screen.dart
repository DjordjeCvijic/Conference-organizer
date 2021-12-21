import 'package:conference_organizer_app/providers/session_editing_provider.dart';
import 'package:conference_organizer_app/widgets/alert_dialog_add_edit_event.dart';
import 'package:conference_organizer_app/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionEditingScreen extends StatelessWidget {
  const SessionEditingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final sessionId = args["sessionId"] as int;
    var _nameController = TextEditingController(text: args["name"]);
    var _descriptionController =
        TextEditingController(text: args["description"]);
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider.value(
        value: SessionEditingProvider(),
        builder: (context, child) => Scaffold(
              body: FutureBuilder(
                  future: Provider.of<SessionEditingProvider>(context)
                      .getSessionToEdit(sessionId),
                  builder: (context, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? const CircularProgressIndicator()
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Edit session:",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 50, 50, 0),
                                  child: Center(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          color: Colors.grey[800],
                                          height: 600,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 15, 0),
                                            child: Column(children: [
                                              const MyDivider("General data"),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text("Session name:",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "The field name must not be empty !";
                                                        }
                                                        return null;
                                                      },
                                                      minLines: 1,
                                                      maxLines: 2,
                                                      controller:
                                                          _nameController,
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors
                                                            .grey.shade300,
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          11.0)),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          11.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 70,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        "Session description:",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "The field description must not be empty ";
                                                        }
                                                        return null;
                                                      },
                                                      minLines: 5,
                                                      maxLines: 10,
                                                      controller:
                                                          _descriptionController,
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors
                                                            .grey.shade300,
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          11.0)),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          11.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                            ]),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          //flex: 2,
                                          child: Container(
                                            color: Colors.grey[800],
                                            height: 600,
                                            child: Column(
                                              children: [
                                                const MyDivider("Add event"),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 0, 15, 0),
                                                  child: SizedBox(
                                                    height: 500,
                                                    child: EventBox(),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      final _sessionEditingProvider =
                                                          Provider.of<
                                                                  SessionEditingProvider>(
                                                              context,
                                                              listen: false);
                                                      _sessionEditingProvider
                                                          .sessionToEdit
                                                          .setName(
                                                              _nameController
                                                                  .text);
                                                      _sessionEditingProvider
                                                          .sessionToEdit
                                                          .setDescription(
                                                              _descriptionController
                                                                  .text);

                                                      _sessionEditingProvider
                                                          .saveSession()
                                                          .then((value) {
                                                        if (value) {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Information'),
                                                              content: const Text(
                                                                  'Session was successfully saved'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        } else {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Warning'),
                                                              content: const Text(
                                                                  'An error has occurred'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      });
                                                    },
                                                    child: const Text(
                                                        "Save session")),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
            ));
  }
}

class EventBox extends StatefulWidget {
  const EventBox({Key? key}) : super(key: key);

  @override
  _EventBoxState createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  int eventNumber = 0;
  setStateCallBack() {
    //napravljeno samo da izrenderuje ponovo Box ako je dodana ili uklonjena nova stavka
    setState(() {
      eventNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _sessionEditingProvider =
        Provider.of<SessionEditingProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          height: 50,
          child: Row(
            children: [
              const Expanded(
                  flex: 3,
                  child: Text("    Add event",
                      style: TextStyle(
                          //za naslove za svaku stanicu
                          fontSize: 20,
                          color: Colors.white))),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    final _formKey = GlobalKey<FormState>();
                    showDialog(
                        context: context,
                        builder: (_) => ChangeNotifierProvider<
                                SessionEditingProvider>.value(
                              value: _sessionEditingProvider,
                              child: AlertDialogAddEditEvent(
                                formKey: _formKey,
                                callBackFuncion: setStateCallBack,
                                eventToUpdate:
                                    Event(), //psoto ga dodajem eventId ce biti 0
                              ),
                            ));
                  },
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _sessionEditingProvider.sessionToEdit.eventList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
              child: Container(
                color: Colors.blue[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text(_sessionEditingProvider
                          .sessionToEdit.eventList
                          .elementAt(index)
                          .name),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Event event = _sessionEditingProvider
                              .sessionToEdit.eventList
                              .elementAt(index);
                          final _formKey = GlobalKey<FormState>();
                          showDialog(
                              context: context,
                              builder: (_) => ChangeNotifierProvider<
                                      SessionEditingProvider>.value(
                                    value: _sessionEditingProvider,
                                    child: AlertDialogAddEditEvent(
                                      formKey: _formKey,
                                      callBackFuncion: setStateCallBack,
                                      eventToUpdate:
                                          event, //e ovdje je eventID neki koga mjenja
                                    ),
                                  ));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          _sessionEditingProvider.sessionToEdit.removeEvent(
                              _sessionEditingProvider.sessionToEdit.eventList
                                  .elementAt(index));
                          setState(() {
                            eventNumber;
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )),
      ],
    );
  }
}
