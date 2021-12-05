import 'dart:developer';

import 'package:conference_organizer_app/providers/person_provider.dart';
import 'package:conference_organizer_app/providers/session_editing_provider.dart';
import 'package:conference_organizer_app/providers/supervising_provider.dart';
import 'package:provider/provider.dart';

import "../globals.dart" as globals;
import 'package:flutter/material.dart';

class SessionEventCard extends StatefulWidget {
  final Map<String, dynamic>? data;
  const SessionEventCard(this.data, {Key? key}) : super(key: key);

  @override
  State<SessionEventCard> createState() => _SessionEventCardState();
}

class _SessionEventCardState extends State<SessionEventCard> {
  setStateCallBack(String name) {
    setState(() {
      widget.data!["name"] = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _supervisionProvider =
        Provider.of<SupervisingProvider>(context, listen: false);
    return ChangeNotifierProvider.value(
        value: SessionEditingProvider(),
        builder: (context, child) => InkWell(
              child: SizedBox(
                  height: 30,
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(widget.data!["name"],
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text("U sklopu ${widget.data!["partOfName"]}",
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    ),
                  )),
              onTap: () {
                log(widget.data!["type"]);
                if (widget.data!["type"] == "session") {
                  Provider.of<SessionEditingProvider>(context, listen: false)
                      .getSessionToEdit(widget.data!["id"])
                      .then((value) {
                    if (value!) {
                      Navigator.pushNamed(
                          context, globals.sessionEditingScreenRoute,
                          arguments: {
                            "sessionId": widget.data!["id"],
                            "name": widget.data!["name"],
                            "description": widget.data!["description"]
                          });
                    }
                  });
                } else {
                  log(widget.data!["id"].toString());
                  log("ovo ce se izvrsiti kad ase klikne na editovanje veneta " +
                      widget.data!["id"].toString());

                  _supervisionProvider
                      .getEventToEdit(widget.data!["id"])
                      .then((value) {
                    if (value) {
                      final _formKey = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (_) =>
                              ChangeNotifierProvider<SupervisingProvider>.value(
                                value: _supervisionProvider,
                                child: AlertDialogEditEvent(
                                  formKey: _formKey,
                                  callBackFuncion: setStateCallBack,
                                ),
                              ));
                    } else {
                      log("greska pri dohvatanju info o event");
                    }
                  });
                }
                log("ovdje se radi " + widget.data!["type"]);
              },
            ));
  }
}

class AlertDialogEditEvent extends StatefulWidget {
  final dynamic callBackFuncion;
  final GlobalKey<FormState> _formKey;
  const AlertDialogEditEvent(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.callBackFuncion})
      : _formKey = formKey,
        super(key: key);

  @override
  State<AlertDialogEditEvent> createState() => _AlertDialogEditEvent();
}

class _AlertDialogEditEvent extends State<AlertDialogEditEvent> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController lecturerEmailController;
  late TextEditingController accessLinkController;
  late TextEditingController accessPasswordController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: Provider.of<SupervisingProvider>(context, listen: false)
            .eventToEdit
            .name);
    descriptionController = TextEditingController(
        text: Provider.of<SupervisingProvider>(context, listen: false)
            .eventToEdit
            .description);
    lecturerEmailController = TextEditingController(
        text: Provider.of<SupervisingProvider>(context, listen: false)
            .eventToEdit
            .lecturerEmail);
    accessLinkController = TextEditingController(
        text: Provider.of<SupervisingProvider>(context, listen: false)
            .eventToEdit
            .accessLink);
    accessPasswordController = TextEditingController(
        text: Provider.of<SupervisingProvider>(context, listen: false)
            .eventToEdit
            .accessPassword);
  }

  @override
  Widget build(BuildContext context) {
    final _supervisionProvider =
        Provider.of<SupervisingProvider>(context, listen: false);
    return ChangeNotifierProvider(
        create: (context) => PersonProvider(),
        builder: (context, child) => AlertDialog(
              title: const Text("Unesite "),
              content: SizedBox(
                height: 400,
                width: 450,
                child: SingleChildScrollView(
                  child: Form(
                    key: widget._formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Naziv", textAlign: TextAlign.left),
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
                        const Text("Opis", textAlign: TextAlign.left),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Polje ne smije biti prazno!';
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
                        const Text("Lecturer", textAlign: TextAlign.left),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Polje ne smije biti prazno!';
                            }
                            return null;
                          },
                          minLines: 1,
                          maxLines: 2,
                          controller: lecturerEmailController,
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
                        FutureBuilder(
                            future: _supervisionProvider.isEventOnline(),
                            builder: (context, snapshot) => snapshot
                                        .connectionState ==
                                    ConnectionState.waiting
                                ? const CircularProgressIndicator()
                                : snapshot.data == true
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text("Acces Link",
                                              textAlign: TextAlign.left),
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Polje ne smije biti prazno!';
                                              }
                                              return null;
                                            },
                                            minLines: 1,
                                            maxLines: 2,
                                            controller: accessLinkController,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey.shade300,
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11.0)),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11.0)),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text("Access Password",
                                              textAlign: TextAlign.left),
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Polje ne smije biti prazno!';
                                              }
                                              return null;
                                            },
                                            minLines: 3,
                                            maxLines: 3,
                                            controller:
                                                accessPasswordController,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey.shade300,
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11.0)),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11.0)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Text("")),
                        const Text("Resources", textAlign: TextAlign.left),
                        const ResourceBox(),
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
                  child: const Text('Odustani'),
                ),
                TextButton(
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        Provider.of<PersonProvider>(context, listen: false)
                            .personExist(lecturerEmailController.text)
                            .then((value) {
                          if (value) {
                            _supervisionProvider.eventToEdit
                                .setName(nameController.text);
                            _supervisionProvider.eventToEdit
                                .setDescription(descriptionController.text);
                            _supervisionProvider.eventToEdit
                                .setLecturerEmail(lecturerEmailController.text);

                            _supervisionProvider.saveEvent();

                            Navigator.of(context).pop();
                            widget.callBackFuncion(nameController.text);
                          } else {
                            lecturerEmailController.text =
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

class ResourceBox extends StatefulWidget {
  const ResourceBox({Key? key}) : super(key: key);

  @override
  _ResourceBoxState createState() => _ResourceBoxState();
}

class _ResourceBoxState extends State<ResourceBox> {
  int resourceNumber = 0;
  setStateCallBack() {
    //napravljeno samo da izrenderuje ponovo Box ako je dodana ili uklonjena nova stavka
    setState(() {
      resourceNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _supervisingProvider =
        Provider.of<SupervisingProvider>(context, listen: false);
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
              const Expanded(flex: 3, child: DropDownButtonResource()),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    _supervisingProvider.eventToEdit.removeResourceId(
                        _supervisingProvider
                            .selectedResource.id); //ako vec psotoji
                    _supervisingProvider.eventToEdit.addResourceId(
                        _supervisingProvider.selectedResource.id);
                    setStateCallBack();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
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
          itemCount: _supervisingProvider.eventToEdit.resourcesIdList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
              child: Container(
                color: Colors.blue[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text(_supervisingProvider.getResourceName(
                          _supervisingProvider
                              .eventToEdit.resourcesIdList[index])),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          _supervisingProvider.eventToEdit.removeResourceId(
                              _supervisingProvider.resourceList
                                  .elementAt(index)
                                  .id);

                          setStateCallBack();
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

class DropDownButtonResource extends StatefulWidget {
  const DropDownButtonResource({Key? key}) : super(key: key);

  @override
  State<DropDownButtonResource> createState() => _DropDownButtonResource();
}

class _DropDownButtonResource extends State<DropDownButtonResource> {
  Resource selectedResource = Resource();

  @override
  Widget build(BuildContext context) {
    final _supervisingProvider =
        Provider.of<SupervisingProvider>(context, listen: false);

    if (selectedResource.id == 0) {
      //ovo ce se desiti samo prvi put

      log(_supervisingProvider.resourceList.first.name);
      selectedResource = _supervisingProvider.resourceList.first;
      _supervisingProvider.selectedResource =
          _supervisingProvider.resourceList.first;
    }

    log("broj " + _supervisingProvider.resourceList.length.toString());

    return Container(
        // width: 150,
        // height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Resource>(
              value: selectedResource, // currently selected item
              items: _supervisingProvider.resourceList
                  .map((item) => DropdownMenuItem<Resource>(
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
                  selectedResource = value!;
                });
                _supervisingProvider.selectedResource = value!;
              }),
        ));
  }
}
