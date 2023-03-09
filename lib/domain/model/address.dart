class Address {
  Address({
    this.id,
    this.addressName,
    this.longitude,
    this.altitude,
    this.phone,
    this.buildingOrStreetName,
    this.cityName,
    this.countryName,
    this.villaOrApprtmentNumber,
    this.addressAr,
    this.isDeleted,
  });

  String? id;
  String? addressName;
  String? longitude;
  String? altitude;
  String? phone;
  String? villaOrApprtmentNumber;
  String? buildingOrStreetName;
  String? cityName;
  String? countryName;
  bool? isDeleted;
  String? addressAr;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressName: json["addressName"],
        longitude: json["longitude"],
        altitude: json["altitude"],
        phone: json["phone"],
        addressAr: json["addressAr"],
        villaOrApprtmentNumber: json["villaOrApprtmentNumber"],
        isDeleted: json["isDeleted"],
        countryName: json["countryName"],
        cityName: json["cityName"],
        buildingOrStreetName: json["buildingOrStreetName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressName": addressName,
        "longitude": longitude,
        "altitude": altitude,
        "phone": phone,
        "addressAr": addressAr,
        "villaOrApprtmentNumber": villaOrApprtmentNumber,
        "isDeleted": isDeleted,
        "countryName": countryName,
        "cityName": cityName,
        "buildingOrStreetName": buildingOrStreetName
      };
}
