class User {
  String? userName;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? telephone;
  String? birthDate;
  String? referralCode;
  bool? active;
  bool? ghafGold;
  bool? sellerSubmittedForm;
  String? fcmToken;

  User({
    this.userName,
    this.password,
    this.confirmPassword,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.telephone,
    this.birthDate,
    this.referralCode,
    this.active,
    this.ghafGold,
    this.sellerSubmittedForm,
    this.fcmToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    email = json['email'];
    telephone = json['telephone'];
    birthDate = json['birthDate'];
    referralCode = json['referralCode'];
    active = json['active'];
    ghafGold = json['ghafGold'];
    sellerSubmittedForm = json['sellerSubmittedForm'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['role'] = this.role;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['birthDate'] = this.birthDate;
    data['referralCode'] = this.referralCode;
    return data;
  }
}
