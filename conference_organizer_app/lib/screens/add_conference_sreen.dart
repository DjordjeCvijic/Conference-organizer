import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddConferenceScreen extends StatelessWidget {
  const AddConferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String prvi;
    String drugi;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                    child: Column(
                      children: [
                        Container(
                          color: Colors.amber,
                          height: 600,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.red,
                          height: 600,
                          child: DatePickerWidget(prvi),
                        )
                      ],
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
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget(this._prviD, {Key? key}) : super(key: key);
  final String _prviD;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select date'),
          ),
        ],
      ),
    );
  }
}
