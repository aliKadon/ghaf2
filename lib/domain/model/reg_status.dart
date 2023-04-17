class RegStatus {
  String? id;
  bool? status;

  RegStatus({
    this.id,
    this.status,
  });

  factory RegStatus.fromJson(Map<String, dynamic> json) => RegStatus(
        id: json['id'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}
