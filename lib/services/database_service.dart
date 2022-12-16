import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:note_basket_2/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note.dart';

class DatabaseService {
  static late DatabaseService _DatabaseService;

  factory DatabaseService() {
    _DatabaseService = DatabaseService._internal();
    return _DatabaseService;
  }

  DatabaseService._internal();

  Future<Database> _initialDatabase() async {
    var databasesPath = await getDatabasesPath();

    var path = join(databasesPath, "notlar.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "notlar.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}

    return await openDatabase(path, readOnly: false);
  }

  Future<List<Category>> getCategory() async {
    var db = await _initialDatabase();

    var conclusion = await db.query("kategori");

    var category = conclusion
        .map((e) => Category(
            categoryId: e['kategoriID'] as int,
            categoryTitle: e['kategoriBaslik'] as String))
        .toList();

    return category;
  }

  Future<int> addCategory(Category category) async {
    var db = await _initialDatabase();
    Map<String, dynamic> map = {};

    map['kategoriBaslik'] = category.categoryTitle;
    return db.insert("kategori", map);
  }

  Future<int> removeCategory(int categoryId) async {
    var db = await _initialDatabase();

    return db
        .delete("kategori", where: 'kategoriID =? ', whereArgs: [categoryId]);
  }

  Future<int> updateCategory(Category category) async {
    var db = await _initialDatabase();
    Map<String, dynamic> map = {};
    map['kategoriId'] = category.categoryId;
    map['kategoriBaslik'] = category.categoryTitle;
    return db.update("kategori", map,
        where: 'kategoriID =? ', whereArgs: [category.categoryId]);
  }

  Future<List<Note>> getNotes(int categoryId) async {
    var db = await _initialDatabase();
// SELECT * FROM table_name;
var conclusion = await db.rawQuery('SELECT * FROM "not" WHERE kategoriID=$categoryId');
    // var conclusion = await db.query("not");

    var note = conclusion
        .map((e) => Note(
              noteId: e['notID'] as int?,
              categoryId: e['kategoriID'] as int?,
              noteTitle: e['notBaslik'] as String?,
              noteDetail: e['notIcerik'] as String?,
              noteDate: e['notTarih'] as String?,
              notePriority: e['notOncelik'] as int?,

              // categoryId: e['kategoriID'] as int,
              // categoryTitle: e['kategoriBaslik'] as String
            ))
        .toList();

    return note;
  }

  Future<int> addNote(Note note) async {
    var db = await _initialDatabase();
    Map<String, dynamic> map = {};

    map['kategoriID'] = note.categoryId;
    map['notBaslik'] = note.noteTitle;
    map['notIcerik'] = note.noteDetail;
    map['notTarih'] = note.noteDate;
    map['notOncelik'] = note.notePriority;

    return db.insert("not", map);
  }


   Future<int> removeNoteWithCategoryId(int categoryId) async {
    var db = await _initialDatabase();

    return db
        .delete("not", where: 'kategoriID =? ', whereArgs: [categoryId]);
  }

  Future<int> removeNoteId(int noteId) async {
    var db = await _initialDatabase();

    return db
        .delete("not", where: 'notID =? ', whereArgs: [noteId]);
  }
}
