class PopularSearch {
  String? productName;
  num? count;

  PopularSearch({required this.productName, required this.count});


  factory PopularSearch.fromJson(Map<String, dynamic> json) =>
      PopularSearch(productName: json['productName'] ?? '', count: json['count'] ?? 0);

  Map<String,dynamic> toJson() => {
    'productName' : productName,
    'count' : count
  };


}
