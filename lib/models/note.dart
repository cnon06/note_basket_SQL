class Note {
  // int? categoryId;
  // String? categoryTitle;
  // Category({required this.categoryId, required this.categoryTitle});

  // Category.add({required this.categoryTitle});

  int? noteId;
  int? categoryId;
  String? noteTitle;
  String? noteDetail;
  String? noteDate;
  int? notePriority;

  Note({required this.noteId, required this.categoryId, required this.noteTitle, required this.noteDetail, required this.noteDate, required this.notePriority });

   Note.add({ required this.categoryId, required this.noteTitle, required this.noteDetail, required this.noteDate, required this.notePriority });

  @override
  String toString() {
    // TODO: implement toString
    return "noteId: $noteId, categoryId: $categoryId, noteTitle: $noteTitle, noteDetail: $noteDetail, noteDate: $noteDate, notePriority: $notePriority";
  }
}