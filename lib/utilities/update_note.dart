import 'package:flutter/material.dart';
import 'package:note_basket_2/globals/global.dart';

import 'package:note_basket_2/services/database_service.dart';

import '../models/note.dart';

void updateNote(
    {required BuildContext context,
    required DatabaseService db,
    required int index,
    required List<Note> noteList,
    // required List<Category> listCategory,
    required Function setState}) {
  // var dropDownMenuController = "One";
  var formKey1 = GlobalKey<FormState>();
 late  String title;
  late String content;
   late int dropDownMenuController;

  showModalBottomSheet(
      backgroundColor: const Color(0x00737373),
      context: context,
      builder: (BuildContext context) {
        dropDownMenuController = noteList[index].notePriority as int;
        dropDownValue = dropDownMenuController;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Text(
                  "Update The Task",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Form(
                  key: formKey1,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: noteList[index].noteTitle,
                              decoration: const InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                validator(formKey1);
                              },
                              onSaved: (value) {
                                title = value!;
                              },
                              validator: (value) {
                                if (value!.trim().length < 3) {
                                  return 'Enter a content with 3 letters at least.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: noteList[index].noteDetail,
                              decoration: const InputDecoration(
                                labelText: 'Content',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                validator(formKey1);
                                // if (formKey1.currentState!.validate()) {
                                //   // formKey1.currentState!.save();
                                // }
                              },
                              onSaved: (value) {
                                content = value!;
                              },
                              validator: (value) {
                                if (value!.trim().length < 3) {
                                  return 'Enter a content with 3 letters at least.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Priority: "),

                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter kamil) {
                      return DropdownButton<int>(
                          value: dropDownMenuController,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("One"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Two"),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("Three"),
                            ),
                          ],
                          onChanged: (value) {
                           
                            dropDownMenuController = value!;
                            dropDownValue = dropDownMenuController;
                            kamil(() {});
                          });
                    })

                    // MyDropDown(),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey1.currentState!.validate()) {
                              formKey1.currentState!.save();

                              db
                                  .updateNote(Note.update(
                                      noteId: noteList[index].noteId,
                                      noteTitle: title.trim(),
                                      noteDetail: content.trim(),
                                      noteDate: DateTime.now().toString(),
                                      notePriority: dropDownValue))
                                  .then((value) {
                                setState();
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Save")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

void validator(GlobalKey<FormState> formKey1) {
  if (formKey1.currentState!.validate()) {
    // formKey1.currentState!.save();
  }
}
