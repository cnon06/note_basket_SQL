import 'package:flutter/material.dart';
import 'package:note_basket_2/services/database_service.dart';

import '../models/category.dart';
import '../models/note.dart';

void addNote({required BuildContext context, required DatabaseService db, required int index, required List<Category> listCategory, required Function setState}) 
{
  showModalBottomSheet(
                            backgroundColor: const Color(0x00737373),
                            context: context,
                            builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                db
                                                    .addNote(Note.add(
                                                        categoryId:
                                                            listCategory[index]
                                                                .categoryId,
                                                        noteTitle: 'noteTitle',
                                                        noteDetail:
                                                            'noteDetail',
                                                        noteDate: DateTime.now()
                                                            .toString(),
                                                        notePriority: 2))
                                                    .then((value) {
                                                  setState();
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text("Save")),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel")),
                                        ),
                                      ],
                                    ), // Text("showModalBottomSheet")
                                  ),
                                ));
}
