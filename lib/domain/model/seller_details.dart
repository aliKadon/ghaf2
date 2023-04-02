class SellerDetails {
  String? firstName;
  String? lastName;
  String? birthDate;
  String? userName;
  String? email;
  String? telephone;
  String? role;
  String? referralCode;
  String? active;
  String? sellerSubmittedForm;
  String? submittedFormStatus;
  num? submittedFormStatusBool;

  SellerDetails({
    this.email,
    this.role,
    this.active,
    this.sellerSubmittedForm,
    this.telephone,
    this.lastName,
    this.firstName,
    this.birthDate,
    this.referralCode,
    this.submittedFormStatus,
    this.submittedFormStatusBool,
    this.userName,
  });

  factory SellerDetails.fromJson(Map<String, dynamic> json) => SellerDetails(
        email: json['email'],
        role: json['role'],
        telephone: json['telephone'],
        active: json['active'],
        birthDate: json['birthDate'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        referralCode: json['referralCode'],
        sellerSubmittedForm: json['sellerSubmittedForm'],
        submittedFormStatus: json['submittedFormStatus'],
        submittedFormStatusBool: json['submittedFormStatusBool'],
        userName: json['userName'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'role': role,
        'telephone': telephone,
        'active': active,
        'birthDate': birthDate,
        'firstName': firstName,
        'lastName': lastName,
        'referralCode': referralCode,
        'sellerSubmittedForm': sellerSubmittedForm,
        'submittedFormStatus': submittedFormStatus,
        'submittedFormStatusBool': submittedFormStatusBool,
        'userName': userName,
      };
}
