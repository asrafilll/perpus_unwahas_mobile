class BookModel {
  final int id;
  final String title;
  final String teachers;
  final String cover;
  final int year;
  final String course;
  final String isbn;
  final String url;
  final int categoryId;
  final String createdAt;
  final CategoryModel category;

  BookModel({
    required this.id,
    required this.title,
    required this.teachers,
    required this.cover,
    required this.year,
    required this.course,
    required this.isbn,
    required this.url,
    required this.categoryId,
    required this.createdAt,
    required this.category,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      teachers: json['teachers'],
      cover: json['cover'],
      year: json['year'],
      course: json['course'],
      isbn: json['ISBN'],
      url: json['url'],
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
      category: CategoryModel.fromJson(json['category']),
    );
  }
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
