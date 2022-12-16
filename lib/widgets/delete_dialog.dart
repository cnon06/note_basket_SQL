import 'package:flutter/material.dart';
import 'package:note_basket_2/models/note.dart';

import '../models/category.dart';
import '../services/database_service.dart';

categoryDeleteDialog(
    {required BuildContext context,
    required List<Category> listCategory,
    required int index,
    required DatabaseService db,
    required Function setState}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
              'Are You Sure To Delete ${listCategory[index].categoryTitle}?'),
          children: [
            ButtonBar(
              children: [
                ElevatedButton(
                    onPressed: () {
                      // db.removeNoteWithCategoryId(
                      //     1);

                      db
                          .removeNoteWithCategoryId(
                              listCategory[index].categoryId as int)
                          .then((thenValue) {
                        if (thenValue != 0)
                          print('fs454:  data has been deleted.');
                      });

                      db
                          .removeCategory(listCategory[index].categoryId as int)
                          .then((thenValue) {
                        if (thenValue != 0)
                          print('fsd16f34:  data has been deleted.');
                      });

                      setState();
                      Navigator.pop(context);
                    },
                    child: Text('OK')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
              ],
            )
          ],
        );
      });
}

noteDeleteDialog(
    {required BuildContext context,
    required List<Note> noteList,
    required int index,
    required DatabaseService db,
    required Function setState}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Are You Sure To Delete ${noteList[index].noteTitle}?'),
          children: [
            ButtonBar(
              children: [
                ElevatedButton(
                    onPressed: () {
                      // db.removeNoteWithCategoryId(
                      //     1);

                      db
                          .removeNoteId(
                              noteList[index].noteId as int)
                          .then((thenValue) {
                        if (thenValue != 0)
                          print('fs454:  data has been deleted.');
                      });

                      // db
                      //     .removeCategory(listCategory[index].categoryId as int)
                      //     .then((thenValue) {
                      //   if (thenValue != 0)
                      //     print('fsd16f34:  data has been deleted.');
                      // });

                      setState();
                      Navigator.pop(context);
                    },
                    child: Text('OK')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
              ],
            )
          ],
        );
      });
}
