class Adds {
  String? id;
  String? addImage;
  String? startDate;
  String? expireDate;
  String? addedAt;
  String? addHeader;
  String? addDescription;
  String? addFooter;
  String? imageToShow;

  Adds({
    this.id,
    this.addedAt,
    this.addDescription,
    this.addFooter,
    this.addHeader,
    this.addImage,
    this.expireDate,
    this.imageToShow,
    this.startDate,
  });

  factory Adds.fromJson(Map<String, dynamic> json) => Adds(
        id: json['id'],
        addedAt: json['addedAt'],
        addDescription: json['addDescription'],
        addFooter: json['addFooter'],
        addHeader: json['addHeader'],
        addImage: json['addImage'],
        expireDate: json['expireDate'],
        imageToShow: json['imageToShow'],
        startDate: json['startDate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'addedAt': addedAt,
        'addDescription': addDescription,
        'addFooter': addFooter,
        'addHeader': addHeader,
        'addImage': addImage,
        'expireDate': expireDate,
        'imageToShow': imageToShow,
        'startDate': startDate,
      };
}
