class Category {
  String? id;
  String? name;
  String? categoryImage;

  Category({
    this.id,
    this.name,
    this.categoryImage,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryImage = json['categoryImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categoryImage'] = this.categoryImage;
    return data;
  }
}
