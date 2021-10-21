import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  const MyTextForm({
    Key? key,
    required TextEditingController textFildController,
    required String errorMsg,
    required String hint,
  })  : _textFildController = textFildController,
        _hint = hint,
        _errorMsg = errorMsg,
        super(key: key);

  final TextEditingController _textFildController;
  final String _hint;
  final String _errorMsg;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return _errorMsg;
        }
        return null;
      },
      controller: _textFildController,
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
          hintText: _hint,
          hintStyle: const TextStyle(fontSize: 12)),
    );
  }
}
