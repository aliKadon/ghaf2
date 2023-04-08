class CustomerNotification {
  String? id;
  String? header;
  String? body;
  String? date;
  num? type;
  bool? isRead;

  CustomerNotification({
    this.body,
    this.id,
    this.type,
    this.date,
    this.header,
    this.isRead,
  });

  factory CustomerNotification.fromJson(Map<String, dynamic> json) =>
      CustomerNotification(
        id: json['id'],
        body: json['body'],
        date: json['date'],
        type: json['type'],
        header: json['header'],
        isRead: json['isRead'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'body': body,
        'date': date,
        'type': type,
        'header': header,
        'isRead': isRead,
      };
}
