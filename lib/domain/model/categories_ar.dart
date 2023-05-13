class CategoriesAr {
  String? id;
  String? categoriesId;
  String? name;

  CategoriesAr({this.name,this.id,this.categoriesId});

  factory CategoriesAr.fromJson(Map<String,dynamic> json) => CategoriesAr(
    id: json['id'],
    name: json['name'],
    categoriesId: json['categoriesId'],
  );
}