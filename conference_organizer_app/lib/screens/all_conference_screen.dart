import 'package:conference_organizer_app/providers/conference_provider.dart';
import 'package:conference_organizer_app/widgets/conference_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllConferenceScreen extends StatefulWidget {
  const AllConferenceScreen({Key? key}) : super(key: key);

  @override
  State<AllConferenceScreen> createState() => _AllConferenceScreenState();
}

class _AllConferenceScreenState extends State<AllConferenceScreen> {
  var chosenTab = 0;
  @override
  Widget build(BuildContext context) {
    final conferenceProvider = Provider.of<ConferenceProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 300,
              child: CustomTabElevatedButton(
                tabTitle: "All conferences",
                active: chosenTab == 0,
                onTap: () {
                  if (chosenTab != 0) {
                    setState(
                      () {
                        chosenTab = 0;
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: CustomTabElevatedButton(
                tabTitle: "My conferences",
                active: chosenTab == 1,
                onTap: () {
                  if (chosenTab != 1) {
                    setState(
                      () {
                        chosenTab = 1;
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        // Text(
        //   "All conferences:",
        //   style: Theme.of(context).textTheme.headline3,
        // ),
        FutureBuilder(
            future: conferenceProvider.getAllConferences(chosenTab),
            builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
                            child: GridView.count(
                              shrinkWrap: true,
                              primary: false,
                              // padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 25,
                              crossAxisCount: 6,
                              children:
                                  List.generate(snapshot.data!.length, (index) {
                                return Container(
                                    child:
                                        ConferenceCard(snapshot.data![index]));
                              }),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Nema podataka,",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )),
      ],
    );
  }
}

class CustomTabElevatedButton extends StatelessWidget {
  final bool active;
  final String tabTitle;
  final Function? onTap;

  const CustomTabElevatedButton({
    Key? key,
    this.active = false,
    this.tabTitle = "",
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap!(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          tabTitle,
          style: TextStyle(
              color: !active ? Colors.grey : Colors.white, fontSize: 28),
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
      ),
    );
  }
}
