class SocialMediaAccounts {
  String? id;
  String? facebookAccount;
  String? instagramAccount;
  String? twitterAccount;

  SocialMediaAccounts({this.id, this.facebookAccount, this.instagramAccount,this.twitterAccount});

  factory SocialMediaAccounts.fromJson(Map<String, dynamic> json) =>
      SocialMediaAccounts(
        id: json['id'],
        facebookAccount: json['facebookAccount'],
        instagramAccount: json['instagramAccount'],
        twitterAccount: json['twitterAccount'],
      );
}
