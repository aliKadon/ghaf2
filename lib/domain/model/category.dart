import 'categories_ar.dart';

class Category {
  String? id;
  String? name;
  String? categoryImage;
  CategoriesAr? categoriesAr;
  String? categoryImageData;

  Category({
    this.id,
    this.name,
    this.categoryImage,
    this.categoriesAr,
    this.categoryImageData,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryImage = json['categoryImage'];
    categoryImageData = json['categoryImageData'];
    categoriesAr = json['categoriesAr'] == null ? null : CategoriesAr.fromJson(json['categoriesAr']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categoryImage'] = this.categoryImage;
    data['categoryImageData'] = this.categoryImageData;
    data['categoriesAr'] = this.categoriesAr;
    return data;
  }
}
