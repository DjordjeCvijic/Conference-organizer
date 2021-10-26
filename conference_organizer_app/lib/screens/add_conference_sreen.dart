import 'dart:developer';

import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/widgets/my_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AddConferenceScreen extends StatelessWidget {
  const AddConferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _conferenceProvider =
        Provider.of<ConferenceProvider>(context, listen: false);
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
                      color: Colors.amber,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          children: [
                            const Text("Opsti podaci"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("naziv konferencije:",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                                  child: Text(" konferencije:",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                          ],
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        height: 600,
                        child: Column(
                          children: [
                            const Text("Trajanje konferenciej"),
                            const SizedBox(
                              height: 10,
                            ),
                            DatePickerWidget(1, "datum pocetka"),
                            const SizedBox(
                              height: 30,
                            ),
                            DatePickerWidget(2, "datum kraja")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      //flex: 2,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.green,
                            height: 600,
                          )
                        ],
                      ),
                    ),
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
  DatePickerWidget(this.tmp, this.text, {Key? key}) : super(key: key);
  int tmp;
  String text;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState(tmp, text);
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();
  late int _category;
  late String _text;
  _DatePickerWidgetState(int tmp, String text) {
    _category = tmp;
    _text = text;
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
          conferenceProvider.setDateFrom(picked.toString());
        } else {
          conferenceProvider.setDateTo(picked.toString());
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
                  style: Theme.of(context).textTheme.bodyText2),
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
