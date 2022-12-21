import 'package:flutter/material.dart';
import 'package:note_basket_2/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
   
    // DatabaseHelper.initialDatabase();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
    );
  }
}
