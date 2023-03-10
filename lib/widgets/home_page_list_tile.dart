import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_basket_2/utilities/update_note.dart';

import '../models/category.dart';
import '../models/note.dart';
import '../services/database_service.dart';
import '../utilities/add_note.dart';
import '../utilities/category_dialog.dart';
import '../utilities/delete_dialog.dart';

// ignore: must_be_immutable
class HomePageListTile extends StatelessWidget {
  DatabaseService db;
  List<Category> listCategory;
  int index;
  Function setState;

  HomePageListTile(
      {Key? key, required this.db,
      required this.listCategory,
      required this.index,
      required this.setState}) : super(key: key) {
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
      color: Theme.of(context).primaryColor,
      child: ExpansionTile(
          textColor: Theme.of(context).hintColor,
          iconColor: Theme.of(context).hintColor,
          collapsedTextColor: Theme.of(context).cardColor,
          collapsedIconColor: Theme.of(context).cardColor,
          title: ListTile(
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
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              title: Text(
                listCategory[index].categoryTitle.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        addNote(
                          context: context,
                          db: db,
                          index: index,
                          listCategory: listCategory,
                          setState: setState,
                        );

                        
                      },
                      icon: const Icon(Icons.add)),
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
                       
                      },
                      icon: const Icon(Icons.update)),
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
                      icon: const Icon(Icons.delete)),
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
                          constraints: const BoxConstraints(maxHeight: 300),
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
                                      onTap: () {
                                        updateNote(
                                            context: context,
                                            db: db,
                                            index: index,
                                            noteList: listNotes,
                                            setState: setState);
                                      },
                                      leading: CircleAvatar(
                                        child: Text(listNotes[index]
                                            .notePriority
                                            .toString()),
                                      ),
                                      title: Text(listNotes[index]
                                          .noteTitle
                                          .toString()),
                                      subtitle: Text(dateFormat(listNotes[index]
                                          .noteDate!)), // listNotes[index].noteDate.toString()),
                                      trailing: IconButton(
                                          onPressed: () {
                                            noteDeleteDialog(
                                              context: context,
                                              db: db,
                                              index: index,
                                              noteList: listNotes,
                                              setState: setState,
                                            );
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ]),
    );
    
  }

  String dateFormat(String dTime) {
    String y = DateFormat.y().format(DateTime.parse(dTime));
    String M = DateFormat.M().format(DateTime.parse(dTime));
    String d = DateFormat.d().format(DateTime.parse(dTime));
    String hms = DateFormat.Hm().format(DateTime.parse(dTime));
    return '$d-$M-$y $hms';
  }
}
