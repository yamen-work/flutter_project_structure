class Category {
  final int? id;
  final String categoryName;
  final List<String> categoryList;

  Category({
    this.id,
    required this.categoryName,
    required this.categoryList,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryList: List<String>.from(json['categoryList'].map((item) => item)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'categoryList': categoryList.map((item) => item).toList(),
    };
  }

}
