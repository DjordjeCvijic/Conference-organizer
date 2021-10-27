import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final String text;
  const MyDivider(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(right: 20.0),
            child: const Divider(
              color: Colors.white,
              height: 36,
            )),
      ),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(
              left: 20.0,
            ),
            child: const Divider(
              color: Colors.white,
              height: 36,
            )),
      ),
    ]);
  }
}
