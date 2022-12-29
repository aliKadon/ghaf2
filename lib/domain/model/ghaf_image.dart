class GhafImage {
  GhafImage({
    this.id,
    this.data,
    this.productsId,
  });

  String? id;
  String? data;
  String? productsId;

  factory GhafImage.fromJson(Map<String, dynamic> json) => GhafImage(
        id: json["id"],
        data: json["data"],
        productsId: json["productsId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data,
        "productsId": productsId,
      };
}
