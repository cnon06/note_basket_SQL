class Category {
  int? categoryId;
  String? categoryTitle;
  Category({required this.categoryId, required this.categoryTitle});

  Category.add({required this.categoryTitle});

 

  @override
  String toString() {
    // TODO: implement toString
    return "categoryId: $categoryId, categoryTitle: $categoryTitle";
  }
}
