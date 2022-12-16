import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/category.dart';
import '../models/note.dart';
import '../services/database_service.dart';
import 'category_dialog.dart';
import 'delete_dialog.dart';

class HomePageListTile extends StatelessWidget {
  DatabaseService db;
  List<Category> listCategory;
  int index;
  Function setState;

  HomePageListTile(
      {required this.db,
      required this.listCategory,
      required this.index,
      required this.setState}) {
    noteList = getNoteList();
  }

  late Future<List<Note>> noteList;

  Future<List<Note>> getNoteList() async {
    return await db.getNotes(listCategory[index].categoryId as int);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Theme.of(context).primaryColor, // Colors.blue,
      child: ExpansionTile(
          textColor: Theme.of(context).hintColor,
          iconColor: Theme.of(context).hintColor,
          collapsedTextColor: Theme.of(context).cardColor,
          collapsedIconColor: Theme.of(context).cardColor,
          title: ListTile(
              // textColor:  Theme.of(context).cardColor,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: Theme.of(context).primaryColor,
                child: FutureBuilder<List<Note>>(
                  future: noteList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var list = snapshot.data;
                      return Text(
                        list!.length.toString(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              title: Text(
                listCategory[index].categoryTitle.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () {
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

                        print('dd865: pressed add button');
                        // setState();
                        // setState();
                      },
                      icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        categoryDialog(
                          context: context,
                          status: Status.update,
                          db: db,
                          listCategory: listCategory,
                          index: index,
                          setState: setState,
                        );
                        print('dd865: pressed update button');
                      },
                      icon: Icon(Icons.update)),
                  IconButton(
                      onPressed: () {
                        categoryDeleteDialog(
                          context: context,
                          db: db,
                          index: index,
                          listCategory: listCategory,
                          setState: setState,
                        );
                     
                      },
                      icon: Icon(Icons.delete)),
                ],
              )),
          children: [
            Column(
              children: [
                FutureBuilder<List<Note>>(
                    future: noteList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var listNotes = snapshot.data;
                        return Container(
                          constraints: BoxConstraints(maxHeight: 300),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: listNotes!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.5),
                                  child: Card(
                                    color: Theme.of(context).backgroundColor,
                                    child: ListTile(
                                      title: Text(
                                          listNotes[index].noteId.toString()),
                                      trailing: IconButton(
                                          onPressed: () {
                                            noteDeleteDialog(context: context, db: db, index: index, noteList: listNotes, setState: setState, );
                                           
                                          },
                                          icon: Icon(Icons.delete)),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ]),
    );
    ;
  }
}
