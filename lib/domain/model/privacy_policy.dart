class PrivacyPolicy {
  String? id;
  String? valueEn;
  String? valueAr;
  String? termsAndConditionsEn;
  String? termsAndConditionsAr;

  PrivacyPolicy({
    this.id,
    this.termsAndConditionsAr,
    this.termsAndConditionsEn,
    this.valueAr,
    this.valueEn,
  });

  factory PrivacyPolicy.fromJson(Map<String,dynamic> json) => PrivacyPolicy(
    id: json['id'],
    termsAndConditionsAr: json['termsAndConditionsAr'],
    termsAndConditionsEn: json['termsAndConditionsEn'],
    valueAr: json['valueAr'],
    valueEn: json['valueEn'],
  );
}
