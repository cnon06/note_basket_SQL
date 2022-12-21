import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:note_basket_2/models/category.dart';

import '../services/database_service.dart';

enum Status {
  update,
  add,
}

Future<dynamic> categoryDialog(
    {required BuildContext context,
    required Status status,
    required DatabaseService db,
    required List<Category> listCategory,
    required Function setState,
    required int index}) {
  var formKey = GlobalKey<FormState>();
  String headTitle = StringUtils.capitalize(status.name);
  var textEditingCont = TextEditingController();

    if(status == Status.update)  textEditingCont.text = listCategory[index].categoryTitle.toString();

  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        
        return SimpleDialog(
          title: Text(' $headTitle Category'),
          children: [
            Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textEditingCont,
                    decoration: const InputDecoration(
                        labelText: 'Category Name',
                        border: OutlineInputBorder()),
                    onSaved: (value) {
                      switch (status) {
                        case Status.add:
                          db
                              .addCategory(
                                  Category.add(categoryTitle: value!.trim()))
                              .then((thenValue) {
                            if (thenValue != 0) {
                              debugPrint(
                                  'fsd16: data has been added to database.');
                            }
                          });

                          break;

                        case Status.update:
                    
                          db
                              .updateCategory(Category(
                                  categoryId: listCategory[index].categoryId,
                                  categoryTitle: value!.trim()))
                              .then((thenValue) {
                            if (thenValue != 0) {
                              debugPrint('fsd17: data has been updated.');
                            }
                          });

                          break;
                      }

                      Navigator.pop(context);
                    },
                    validator: (value) {
                      // print('e233: ${value!.length}');
                      if (value!.length < 3) {
                        return 'Enter a category name with 3 letters at least.';
                      }

                      bool containsIt = false;
                      for (var element in listCategory) {
                        if (element.categoryTitle!.toLowerCase() ==
                            value.trim().toLowerCase()) containsIt = true;
                      }

                      if (containsIt) {
                        return 'You must enter a different value than those in the Categories list.';
                      }
                      return null;
                    },
                  ),
                )),
            ButtonBar(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      }

                      setState();
                    },
                    child: const Text('OK')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ],
            )
          ],
        );
      });
}
