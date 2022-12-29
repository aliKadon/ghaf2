class Address {
  Address({
    this.id,
    this.addressName,
    this.longitude,
    this.altitude,
    this.phone,
  });

  String? id;
  String? addressName;
  String? longitude;
  String? altitude;
  String? phone;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressName: json["addressName"],
        longitude: json["longitude"],
        altitude: json["altitude"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressName": addressName,
        "longitude": longitude,
        "altitude": altitude,
        "phone": phone,
      };
}
