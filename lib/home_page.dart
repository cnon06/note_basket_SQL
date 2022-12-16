import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:note_basket_2/models/category.dart';
import 'package:note_basket_2/widgets/category_dialog.dart';
import 'package:note_basket_2/widgets/home_page_list_tile.dart';
import 'package:sqflite/sqflite.dart';

import 'models/note.dart';
import 'services/database_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseService db;

  late List<Category> listCategory;

  void getNotes() async {
    // print('ffd443: ${await db.getCategory()}');
    // print('ffsd6756: ${await db.getNotes()}');
  }

  @override
  void initState() {
    db = DatabaseService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getNotes();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Categories'),
      // ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                categoryDialog(
                    context: context,
                    status: Status.add,
                    db: db,
                    listCategory: listCategory,
                    index: 0,
                    setState: () {
                      setState(() {});
                    }
                    
                    );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Category>>(
        future: db.getCategory(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            listCategory = snapshot.data;

            return ListView.builder(
              // shrinkWrap: true,
                itemCount: listCategory.length,
                itemBuilder: (context, index) {
                  return HomePageListTile(
                      db: db,
                      listCategory: listCategory,
                      index: index,
                      setState: (){setState(() {
                        
                      }); } );
                  
                  

                  
                  
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
