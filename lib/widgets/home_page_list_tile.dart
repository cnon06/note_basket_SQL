import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:note_basket_2/widgets/add_note.dart';

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
                        addNote(
                          context: context,
                          db: db,
                          index: index,
                          listCategory: listCategory,
                          setState: setState,
                        );

                        print('dd865: pressed add button');
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
                                      leading: CircleAvatar(child: Text(listNotes[index].notePriority.toString()),),
                                      title: Text(
                                          listNotes[index].noteTitle.toString()),
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

  String dateFormat(String dTime) {
    String ymd = DateFormat.yMMMd().format(DateTime.parse(dTime));
    String y = DateFormat.y().format(DateTime.parse(dTime));
    String M = DateFormat.M().format(DateTime.parse(dTime));
    String d = DateFormat.d().format(DateTime.parse(dTime));
     String hms = DateFormat.Hm().format(DateTime.parse(dTime));
    return '$d-$M-$y $hms' ;
  }
}
