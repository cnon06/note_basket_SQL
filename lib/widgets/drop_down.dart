
import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
 MyDropDown({Key? key}) : super(key: key);
  var dropDownMenuController = 'One';

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
                            builder: (BuildContext context, StateSetter kamil) {
                          return DropdownButton<String>(
                              value: dropDownMenuController,
                              items: [
                                DropdownMenuItem(
                                  child: Text("One"),
                                  value: "One",
                                ),
                                DropdownMenuItem(
                                  child: Text("Two"),
                                  value: "Two",
                                ),
                                DropdownMenuItem(
                                  child: Text("Three"),
                                  value: "Three",
                                ),
                              ],
                              onChanged: (value) {
                                print('54dd: $value');

                                kamil(() {});
                                dropDownMenuController = value!;

                                
                              });
                        });
  }
}