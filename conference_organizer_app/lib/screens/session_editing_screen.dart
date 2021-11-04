import 'package:conference_organizer_app/providers/session_editing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionEditingScreen extends StatelessWidget {
  const SessionEditingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: SessionEditingProvider(),
        builder: (context, child) => Scaffold(
              body: FutureBuilder(
                  future: Provider.of<SessionEditingProvider>(context)
                      .getSessionToEdit(1),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                Text(Provider.of<SessionEditingProvider>(
                                        context,
                                        listen: false)
                                    .sessionToEdit
                                    .name)
                              ],
                            )),
            ));
  }
}
