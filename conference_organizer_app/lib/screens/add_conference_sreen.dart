import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/providers/location_provider.dart';
import 'package:conference_organizer_app/providers/person_provider.dart';
import 'package:conference_organizer_app/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddConferenceScreen extends StatelessWidget {
  const AddConferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);
    final _locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    var _nameController = TextEditingController();
    var _descriptionController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              "Add conferences:",
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      color: Colors.grey[800],
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(children: [
                          const MyDivider("Opsti podaci"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Conference name:",
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "morate unijeti naziv";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Conference description:",
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "morate inijeti opis";
                                    }
                                    return null;
                                  },
                                  minLines: 5,
                                  maxLines: 10,
                                  controller: _descriptionController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: Text("conference location:",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            Expanded(
                                flex: 2,
                                child: FutureBuilder(
                                    future: _locationProvider.getAllLocations(),
                                    builder: (context,
                                            AsyncSnapshot<bool?> snapshot) =>
                                        snapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? const CircularProgressIndicator()
                                            : const DropDownButton()))
                          ]),
                        ]),
                      ),
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[800],
                        height: 600,
                        child: Column(
                          children: [
                            const MyDivider("trajanje konferencije"),
                            const SizedBox(
                              height: 10,
                            ),
                            const DatePickerWidget(1, "datum pocetka"),
                            const SizedBox(
                              height: 30,
                            ),
                            const DatePickerWidget(2, "datum kraja"),
                            const SizedBox(
                              height: 30,
                            ),
                            const MyDivider("Grading subject"),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: SizedBox(
                                  height: 286, child: GradingSubjectBox()),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _conferenceProvider.conferenceToSave
                                      .setName(_nameController.text);
                                  _conferenceProvider.conferenceToSave
                                      .setDescription(
                                          _descriptionController.text);
                                  _conferenceProvider
                                      .saveConference()
                                      .then((value) {
                                    if (value) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Obavjestenje'),
                                          content: const Text(
                                              'Konferencija sacuvana'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Obavjestenje'),
                                          content:
                                              const Text('Doslo je do greske'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: const Text("save")),
                          ],
                        ),
                      ),
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
                        children: const [
                          MyDivider("Dodaj sesije"),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: SizedBox(
                              height: 500,
                              child: SessionBox(),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget(this.tmp, this.text, {Key? key}) : super(key: key);
  final int tmp;
  final String text;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();
  late int _category;
  late String _text;

  @override
  void initState() {
    super.initState();
    _category = widget.tmp;
    _text = widget.text;
  }

  Future<void> _selectDate(
      BuildContext context, ConferenceProvider conferenceProvider) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (_category == 1) {
          conferenceProvider.conferenceToSave.setDateFrom(picked.toString());
        } else {
          conferenceProvider.conferenceToSave.setDateTo(picked.toString());
        }
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Text(_text,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline2),
            ),
            Expanded(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(const Size(50, 70)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ))),
                onPressed: () => _selectDate(context, _conferenceProvider),
                label: Text("${selectedDate.toLocal()}".split(' ')[0]),
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  late Location value;

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);
    final _locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    if (_conferenceProvider.conferenceToSave.locationId == 0) {
      _conferenceProvider.conferenceToSave.setLocationId(1);
      value = _locationProvider.listForDropDown.first;
    }

    return Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.deepOrange, width: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Location>(
              value: value, // currently selected item
              items: _locationProvider.listForDropDown
                  .map((item) => DropdownMenuItem<Location>(
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            const SizedBox(width: 8),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        value: item,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  this.value = value!;
                });
                _conferenceProvider.conferenceToSave.setLocationId(value!.id);
              }),
        ));
  }
}

class SessionBox extends StatefulWidget {
  const SessionBox({Key? key}) : super(key: key);

  @override
  _SessionBoxState createState() => _SessionBoxState();
}

class _SessionBoxState extends State<SessionBox> {
  int sessionNumber = 0;
  setStateCallBack() {
    //napravljeno samo da izrenderuje ponovo Box ako je dodana ili uklonjena nova stavka
    setState(() {
      sessionNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);
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
                  child: Text("    Add session",
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
                        builder: (_) =>
                            ChangeNotifierProvider<ConferenceProvider>.value(
                              value: _conferenceProvider,
                              child: AlertDialogForSession(
                                formKey: _formKey,
                                callBackFuncion: setStateCallBack,
                                sessionToUpdate: Session(),
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
          itemCount: _conferenceProvider.conferenceToSave.session.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
              child: Container(
                color: Colors.blue[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text(_conferenceProvider.conferenceToSave.session
                          .elementAt(index)
                          .name),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Session s = _conferenceProvider
                              .conferenceToSave.session
                              .elementAt(index);
                          final _formKey = GlobalKey<FormState>();
                          showDialog(
                              context: context,
                              builder: (_) => ChangeNotifierProvider<
                                      ConferenceProvider>.value(
                                    value: _conferenceProvider,
                                    child: AlertDialogForSession(
                                      formKey: _formKey,
                                      callBackFuncion: setStateCallBack,
                                      sessionToUpdate: s,
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
                          _conferenceProvider.conferenceToSave.removeSession(
                              _conferenceProvider.conferenceToSave.session
                                  .elementAt(index));
                          setState(() {
                            sessionNumber--;
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

class GradingSubjectBox extends StatefulWidget {
  const GradingSubjectBox({Key? key}) : super(key: key);

  @override
  State<GradingSubjectBox> createState() => _GradingSubjectBoxState();
}

class _GradingSubjectBoxState extends State<GradingSubjectBox> {
  int gradingSubjectNumber = 0;
  setStateCallBack() {
    //napravljeno samo da izrenderuje ponovo Box ako je dodana ili uklonjena nova stavka
    setState(() {
      gradingSubjectNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);

    return Column(
      children: [
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
                  child: Text("    Add grading subject",
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
                        builder: (_) =>
                            ChangeNotifierProvider<ConferenceProvider>.value(
                              value: _conferenceProvider,
                              child: AlertDialogForGradingSubjects(
                                formKey: _formKey,
                                callBackFuncion: setStateCallBack,
                                text: " ",
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
        SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:
                  _conferenceProvider.conferenceToSave.gradingSubject.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
                  child: Container(
                    color: Colors.blue[300],
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            _conferenceProvider.conferenceToSave.gradingSubject
                                .elementAt(index),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              String s = _conferenceProvider
                                  .conferenceToSave.gradingSubject
                                  .elementAt(index);
                              final _formKey = GlobalKey<FormState>();
                              showDialog(
                                  context: context,
                                  builder: (_) => ChangeNotifierProvider<
                                          ConferenceProvider>.value(
                                        value: _conferenceProvider,
                                        child: AlertDialogForGradingSubjects(
                                          formKey: _formKey,
                                          callBackFuncion: setStateCallBack,
                                          text: s,
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
                              _conferenceProvider.conferenceToSave
                                  .removeGradingSubject(_conferenceProvider
                                      .conferenceToSave.gradingSubject
                                      .elementAt(index));
                              setState(() {
                                gradingSubjectNumber--;
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

class AlertDialogForGradingSubjects extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final dynamic callBackFuncion;
  final String text;

  const AlertDialogForGradingSubjects(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.callBackFuncion,
      required this.text})
      : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);
    var _enterController = TextEditingController(text: text);
    return AlertDialog(
      title: const Text("Unesite "),
      content: SizedBox(
        height: 150,
        width: 350,
        child: Form(
          key: _formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Polje ne smije biti prazno!';
              }
              return null;
            },
            minLines: 5,
            maxLines: 10,
            controller: _enterController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Odustani'),
        ),
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (text != " ") {
                  //u slucaju ako nine rposlje prazan prostor znaci da se editovalo pa to treba izbaciti

                  _conferenceProvider.conferenceToSave
                      .removeGradingSubject(text);
                }
                _conferenceProvider.conferenceToSave
                    .addGradingSubject(_enterController.text);
                Navigator.of(context).pop();
                callBackFuncion();
              }
            },
            child: const Text('sacuvaj'))
      ],
    );
  }
}

class AlertDialogForSession extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final dynamic callBackFuncion;
  final Session sessionToUpdate;
  const AlertDialogForSession(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.callBackFuncion,
      required this.sessionToUpdate})
      : _formKey = formKey,
        super(key: key);

  @override
  State<AlertDialogForSession> createState() => _AlertDialogForSessionState();
}

class _AlertDialogForSessionState extends State<AlertDialogForSession> {
  bool isChecked = false;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController moderatorEmailController;
  @override
  void initState() {
    super.initState();
    isChecked = widget.sessionToUpdate.isOnline;
    nameController = TextEditingController(text: widget.sessionToUpdate.name);
    descriptionController =
        TextEditingController(text: widget.sessionToUpdate.description);
    moderatorEmailController =
        TextEditingController(text: widget.sessionToUpdate.moderatorEmail);
  }

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);

    return ChangeNotifierProvider(
        create: (context) => PersonProvider(),
        builder: (context, child) => AlertDialog(
              title: const Text("Unesite "),
              content: SizedBox(
                height: 400,
                width: 450,
                child: Form(
                  key: widget._formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Naslov", textAlign: TextAlign.left),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Polje ne smije biti prazno!';
                          }
                          return null;
                        },
                        minLines: 1,
                        maxLines: 2,
                        controller: nameController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("opsoi", textAlign: TextAlign.left),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Polje ne smije biti prazno!';
                          }
                          return null;
                        },
                        minLines: 4,
                        maxLines: 6,
                        controller: descriptionController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("moderator", textAlign: TextAlign.left),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Polje ne smije biti prazno!';
                          }
                          return null;
                        },
                        minLines: 1,
                        maxLines: 2,
                        controller: moderatorEmailController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text("Online"),
                          Checkbox(
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Odustani'),
                ),
                TextButton(
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        Provider.of<PersonProvider>(context, listen: false)
                            .personExist(moderatorEmailController.text)
                            .then((value) {
                          if (value) {
                            if (widget.sessionToUpdate.name != "") {
                              _conferenceProvider.conferenceToSave
                                  .removeSession(widget.sessionToUpdate);
                            }
                            Session sessionToSave = Session.value(
                                moderatorEmailController.text,
                                nameController.text,
                                descriptionController.text,
                                isChecked);

                            _conferenceProvider.conferenceToSave
                                .addSession(sessionToSave);

                            Navigator.of(context).pop();
                            widget.callBackFuncion();
                          } else {
                            moderatorEmailController.text =
                                "PERSON IS NOT IN SYSTEM";
                          }
                        });
                      }
                    },
                    child: const Text('sacuvaj'))
              ],
            ));
  }
}
