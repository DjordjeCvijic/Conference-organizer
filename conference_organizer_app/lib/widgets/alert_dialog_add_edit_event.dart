import 'dart:developer';

import 'package:conference_organizer_app/providers/person_provider.dart';
import 'package:conference_organizer_app/providers/session_editing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertDialogAddEditEvent extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final dynamic callBackFuncion;
  final Event
      eventToUpdate; //ima id 0 ako dodajem ili neki kokretan ako updatujem
  const AlertDialogAddEditEvent(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.callBackFuncion,
      required this.eventToUpdate})
      : _formKey = formKey,
        super(key: key);

  @override
  State<AlertDialogAddEditEvent> createState() => _AlertDialogAddEditEvent();
}

class _AlertDialogAddEditEvent extends State<AlertDialogAddEditEvent> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController moderatorEmailController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.eventToUpdate.name);
    descriptionController =
        TextEditingController(text: widget.eventToUpdate.description);
    moderatorEmailController =
        TextEditingController(text: widget.eventToUpdate.moderatorEmail);
  }

  @override
  Widget build(BuildContext context) {
    final _sessionEditigProvider =
        Provider.of<SessionEditingProvider>(context, listen: false);
    return ChangeNotifierProvider(
        create: (context) => PersonProvider(),
        builder: (context, child) => AlertDialog(
              title: const Text("Enter event data "),
              content: SizedBox(
                height: 400,
                width: 450,
                child: SingleChildScrollView(
                  child: Form(
                    key: widget._formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name", textAlign: TextAlign.left),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The field name must not be empty !';
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
                        const Text("Description", textAlign: TextAlign.left),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The field description must not be empty !';
                            }
                            return null;
                          },
                          minLines: 3,
                          maxLines: 3,
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
                        const Text("Moderator", textAlign: TextAlign.left),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The field moderator must not be empty !';
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
                        Row(children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              "Event type:",
                              textAlign: TextAlign.left,
                              // style: Theme.of(context).textTheme.headline2
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: FutureBuilder(
                                  future:
                                      _sessionEditigProvider.getAllEventTypes(),
                                  builder: (context,
                                          AsyncSnapshot<bool?> snapshot) =>
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? const CircularProgressIndicator()
                                          : DropDownButtonForEventType(
                                              widget.eventToUpdate)))
                        ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Place:",
                              textAlign: TextAlign.left,
                              // style: Theme.of(context).textTheme.headline2
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: FutureBuilder(
                                  future: _sessionEditigProvider
                                      .getAllPlacesForLocation(),
                                  builder: (context,
                                          AsyncSnapshot<bool?> snapshot) =>
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? const CircularProgressIndicator()
                                          : DropDownButtonForPlace(
                                              widget.eventToUpdate)))
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePickerWidget(widget.eventToUpdate, "Date"),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: TimePickerWidget(
                                    widget.eventToUpdate, "Start: ", 1)),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                flex: 1,
                                child: TimePickerWidget(
                                    widget.eventToUpdate, "End: ", 2))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        Provider.of<PersonProvider>(context, listen: false)
                            .personExist(moderatorEmailController.text)
                            .then((value) {
                          if (value) {
                            widget.eventToUpdate.setName(nameController.text);
                            widget.eventToUpdate
                                .setDescription(descriptionController.text);
                            widget.eventToUpdate.setModeratorEmail(
                                moderatorEmailController.text);
                            //ovdje tereba i ostalo dodavati

                            if (_sessionEditigProvider.sessionToEdit.eventList
                                .contains(widget.eventToUpdate)) {
                              _sessionEditigProvider.sessionToEdit.eventList
                                  .remove(widget.eventToUpdate);
                            }

                            _sessionEditigProvider.sessionToEdit
                                .addEvent(widget.eventToUpdate);

                            Navigator.of(context).pop();
                            widget.callBackFuncion();
                          } else {
                            moderatorEmailController.text =
                                "PERSON IS NOT IN SYSTEM";
                          }
                        });
                      }
                    },
                    child: const Text('Save'))
              ],
            ));
  }
}

class DropDownButtonForEventType extends StatefulWidget {
  Event _eventToUpdate;
  DropDownButtonForEventType(this._eventToUpdate, {Key? key}) : super(key: key);

  @override
  State<DropDownButtonForEventType> createState() =>
      _DropDownButtonForEventType();
}

class _DropDownButtonForEventType extends State<DropDownButtonForEventType> {
  EventType? value = null;

  @override
  Widget build(BuildContext context) {
    final _sessionEditingProvider =
        Provider.of<SessionEditingProvider>(context, listen: false);

    if (!_sessionEditingProvider.sessionToEdit.eventList
            .contains(widget._eventToUpdate) &&
        value == null) {
      widget._eventToUpdate.setEventTypeId(1);
      value = _sessionEditingProvider.eventTypeList.first;
    } else {
      for (int i = 0; i < _sessionEditingProvider.eventTypeList.length; i++) {
        if (_sessionEditingProvider.eventTypeList.elementAt(i).eventTypeId ==
            widget._eventToUpdate.eventTypeId) {
          value = _sessionEditingProvider.eventTypeList.elementAt(i);
        }
      }
    }

    return Container(
        width: 150,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<EventType>(
              value: value, // currently selected item
              items: _sessionEditingProvider.eventTypeList
                  .map((item) => DropdownMenuItem<EventType>(
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            const SizedBox(width: 8),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
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
                widget._eventToUpdate.setEventTypeId(value!.eventTypeId);
              }),
        ));
  }
}

class DropDownButtonForPlace extends StatefulWidget {
  Event _eventToUpdate;
  DropDownButtonForPlace(this._eventToUpdate, {Key? key}) : super(key: key);

  @override
  State<DropDownButtonForPlace> createState() => _DropDownButtonForPlace();
}

class _DropDownButtonForPlace extends State<DropDownButtonForPlace> {
  Place? valuePlace = null;

  @override
  Widget build(BuildContext context) {
    final _sessionEditingProvider =
        Provider.of<SessionEditingProvider>(context, listen: false);

    if (!_sessionEditingProvider.sessionToEdit.eventList
            .contains(widget._eventToUpdate) &&
        valuePlace == null) {
      widget._eventToUpdate
          .setplaceId(_sessionEditingProvider.placeList.first.locationId);
      valuePlace = _sessionEditingProvider.placeList.first;
    } else {
      for (int i = 0; i < _sessionEditingProvider.placeList.length; i++) {
        if (_sessionEditingProvider.placeList.elementAt(i).placeId ==
            widget._eventToUpdate.placeId) {
          valuePlace = _sessionEditingProvider.placeList.elementAt(i);
        }
      }
    }

    return Container(
        width: 150,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Place>(
              value: valuePlace, // currently selected item
              items: _sessionEditingProvider.placeList
                  .map((item) => DropdownMenuItem<Place>(
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            const SizedBox(width: 8),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        value: item,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  valuePlace = value!;
                });
                widget._eventToUpdate.setplaceId(value!.placeId);
              }),
        ));
  }
}

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget(this.eventToEdit, this.text, {Key? key}) : super(key: key);
  final String text;
  Event eventToEdit;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  late String _text;

  @override
  void initState() {
    super.initState();
    if (widget.eventToEdit.date != "") {
      log("izabrani datum je " +
          DateTime.parse(widget.eventToEdit.date).toString());
      //selectedDate = DateTime.parse(widget.eventToEdit.date);
    }
    _text = widget.text;
  }

  Future<void> _selectDate(BuildContext context,
      SessionEditingProvider sessionEditingProvider) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        widget.eventToEdit.setDate(picked.toString());
        // if (_category == 1) {
        //   conferenceProvider.conferenceToSave.setDateFrom(picked.toString());
        // } else {
        //   conferenceProvider.conferenceToSave.setDateTo(picked.toString());
        // }
        log("izabrani datum u set state je " + picked.toString());
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _sessionEditingProvider =
        Provider.of<SessionEditingProvider>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Text(
                _text,
                textAlign: TextAlign.left,
                // style: Theme.of(context).textTheme.headline2
              ),
            ),
            Expanded(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(const Size(40, 70)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ))),
                onPressed: () => _selectDate(context, _sessionEditingProvider),
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

class TimePickerWidget extends StatefulWidget {
  TimePickerWidget(this.eventToEdit, this.text, this.category, {Key? key})
      : super(key: key);
  final String text;
  Event eventToEdit;
  int category;
  @override
  State<TimePickerWidget> createState() => _TimePickerWidget();
}

class _TimePickerWidget extends State<TimePickerWidget> {
  // TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now()); // 4:30pm

  late String _text;

  @override
  void initState() {
    super.initState();
    log("VRIJEMEEEE  u uinit state" +
        selectedTime.hour.toString() +
        "" +
        selectedTime.minute.toString());
    if ((widget.eventToEdit.timeFrom != "" && widget.category == 1) ||
        (widget.eventToEdit.timeTo != "" && widget.category == 2)) {
      if (widget.category == 1) {
        log("jedan je");
        selectedTime = TimeOfDay(
            hour: int.parse(widget.eventToEdit.timeFrom.split(":")[0]),
            minute: int.parse(widget.eventToEdit.timeFrom.split(":")[1]));
      } else {
        log("dva je");
        selectedTime = TimeOfDay(
            hour: int.parse(widget.eventToEdit.timeTo.split(":")[0]),
            minute: int.parse(widget.eventToEdit.timeTo.split(":")[1]));
      }
    }
    if (widget.category == 1) {
      log("jedan je" +
          selectedTime.hour.toString() +
          "" +
          selectedTime.minute.toString());
      widget.eventToEdit.setTimeFrom(
          selectedTime.hour.toString() + "" + selectedTime.minute.toString());
    } else {
      log("dv je" + selectedTime.toString());
      widget.eventToEdit.setTimeto(
          selectedTime.hour.toString() + "" + selectedTime.minute.toString());
    }

    _text = widget.text;
  }

  Future<void> _selectTime(BuildContext context,
      SessionEditingProvider sessionEditingProvider) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    // firstDate: DateTime(2015, 8),
    // lastDate: DateTime(2101));
    log("vremena koje je izabrano" + picked.toString().substring(10, 15));
    if (picked != null && picked != selectedTime) {
      setState(() {
        if (widget.category == 1) {
          log("postavljeno virjeme " +
              picked.hour.toString() +
              ":" +
              picked.minute.toString());
          widget.eventToEdit.setTimeFrom(
              picked.hour.toString() + ":" + picked.minute.toString());
        } else {
          widget.eventToEdit.setTimeto(
              picked.hour.toString() + ":" + picked.minute.toString());
        }
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _sessionEditingProvider =
        Provider.of<SessionEditingProvider>(context, listen: false);
    log(selectedTime.hour.toString() +
        "" +
        selectedTime.minute.toString() +
        " vrijeeeeeee");
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Text(
                _text,
                textAlign: TextAlign.left,
                // style: Theme.of(context).textTheme.headline2
              ),
            ),
            Expanded(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(const Size(40, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ))),
                onPressed: () => _selectTime(context, _sessionEditingProvider),
                // label: Text("${selectedDate.toLocal()}".split(' ')[0]),
                label: Text(selectedTime.hour.toString() +
                    ":" +
                    selectedTime.minute.toString()),
                icon: const Icon(
                  Icons.access_time_filled_rounded,
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
