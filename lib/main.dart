import 'package:flutter/material.dart';
import 'package:note_basket_2/services/database_service.dart';
import 'package:note_basket_2/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
   
    // DatabaseHelper.initialDatabase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
    );
  }
}
