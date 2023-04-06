import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/user.dart';

enum PrefKeys {
  userName,
  firstName,
  lastName,
  role,
  email,
  telephone,
  token,
  loggedIn,
  lang,
  displayOnBoarding,
  referralCode,
  birthDate,
  active,
  ghafGold,
  sellerSubmittedForm,
  fcmToken,
  language,
  locationLat,
  locationLong,
  googleUserName,
  googleEmail,
  enableNotification,
  firstStoreName,
  city,
  indexOfPayLaterProduct,
  idPayLater,
}

class SharedPrefController {
  SharedPrefController._internal();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._internal();
  }

  ///TO DO CALLED IN MAIN AFTER --WidgetsFlutterBinding-- AND BEFORE runApp()
  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required User user}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setString(PrefKeys.userName.name, user.userName!);
    await _sharedPreferences.setString(
        PrefKeys.firstName.name, user.firstName!);
    await _sharedPreferences.setString(PrefKeys.lastName.name, user.lastName!);
    await _sharedPreferences.setString(PrefKeys.role.name, user.role!);
    await _sharedPreferences.setString(PrefKeys.email.name, user.email!);
    await _sharedPreferences.setString(
        PrefKeys.telephone.name, user.telephone!);
    await _sharedPreferences.setString(
        PrefKeys.referralCode.name, user.referralCode!);
    await _sharedPreferences.setString(
        PrefKeys.birthDate.name, user.birthDate!);
    await _sharedPreferences.setBool(
        PrefKeys.active.name, user.active ?? false);
    await _sharedPreferences.setBool(
        PrefKeys.ghafGold.name, user.ghafGold ?? false);
    await _sharedPreferences.setBool(
        PrefKeys.sellerSubmittedForm.name, user.sellerSubmittedForm ?? false);
    if (user.fcmToken != null)
      await _sharedPreferences.setString(
          PrefKeys.fcmToken.name, user.fcmToken!);
  }

  User? getUser() {
    return _sharedPreferences.getString(PrefKeys.token.name) == null
        ? null
        : AppSharedData.currentUser = User(
            userName: _sharedPreferences.getString(PrefKeys.userName.name),
            firstName: _sharedPreferences.getString(PrefKeys.firstName.name),
            lastName: _sharedPreferences.getString(PrefKeys.lastName.name),
            role: _sharedPreferences.getString(PrefKeys.role.name),
            email: _sharedPreferences.getString(PrefKeys.email.name),
            telephone: _sharedPreferences.getString(PrefKeys.telephone.name),
            referralCode:
                _sharedPreferences.getString(PrefKeys.referralCode.name),
            birthDate: _sharedPreferences.getString(PrefKeys.birthDate.name),
            active: _sharedPreferences.getBool(PrefKeys.active.name),
            ghafGold: _sharedPreferences.getBool(PrefKeys.ghafGold.name),
            sellerSubmittedForm:
                _sharedPreferences.getBool(PrefKeys.sellerSubmittedForm.name),
            fcmToken: _sharedPreferences.getString(PrefKeys.fcmToken.name),
          );
  }

  var key = 'ar';

  Future<bool> clear() async {
    return _sharedPreferences.clear();
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.name) ?? false;

  String get userNameGoogle =>
      _sharedPreferences.getString(PrefKeys.googleUserName.toString()) ?? '';

  String get firstStoreName =>
      _sharedPreferences.getString(PrefKeys.firstStoreName.toString()) ?? '';

  int get indexOfPayLaterProduct =>
      _sharedPreferences.getInt(PrefKeys.indexOfPayLaterProduct.name) ?? 0;

  String get city =>
      _sharedPreferences.getString(PrefKeys.city.name) ?? '';

  String get emailGoogle =>
      _sharedPreferences.getString(PrefKeys.googleEmail.toString()) ?? '';

  String get idPayLater =>
      _sharedPreferences.getString(PrefKeys.idPayLater.name) ?? '';

  String get lang1 {
    return _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';
  }


  double get locationLat {
    return _sharedPreferences.getDouble(PrefKeys.locationLat.toString()) ?? 24.400661;
  }

  double get locationLong {
    return _sharedPreferences.getDouble(PrefKeys.locationLong.toString()) ?? 54.635448;
  }

  bool get enableNotifications =>
      _sharedPreferences.getBool(PrefKeys.enableNotification.toString()) ?? true;



  Future<void> setUserName(String userName) async {
    await _sharedPreferences.setString(PrefKeys.userName.name, '${userName}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setIndexOfPayLaterProduct(int indexOfPayLaterProduct) async {
    await _sharedPreferences.setInt(PrefKeys.indexOfPayLaterProduct.name, indexOfPayLaterProduct);
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setFirstName(String firstName) async {
    await _sharedPreferences.setString(PrefKeys.firstName.name, '${firstName}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setCity(String city) async {
    await _sharedPreferences.setString(PrefKeys.city.name, '${city}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setFirstStoreName(String firstStoretName) async {
    await _sharedPreferences.setString(PrefKeys.firstStoreName.toString(), '${firstStoretName}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }
  Future<void> setLastName(String lastName) async {
    await _sharedPreferences.setString(PrefKeys.lastName.name, '${lastName}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setIdPayLaterProduct(String idPayLaterProduct) async {
    await _sharedPreferences.setString(PrefKeys.idPayLater.name, '${idPayLaterProduct}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setEmail(String email) async {
    await _sharedPreferences.setString(PrefKeys.userName.name, '${email}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setTelephone(String telephone) async {
    await _sharedPreferences.setString(PrefKeys.telephone.name, '${telephone}');
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  Future<void> setEnableNotification(bool enable) async {
      await _sharedPreferences.setBool(PrefKeys.enableNotification.toString(), enable);
    // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  // Future<bool> setLanguage(String language) async {
  //   await _sharedPreferences.setBool();
  //   // _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  // }

  // void set loggedIn(bool loggedIn) => _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);

  String get token => _sharedPreferences.getString(PrefKeys.token.name) ?? '';

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(PrefKeys.token.name, 'Bearer ${token}');
    _sharedPreferences.setBool(PrefKeys.loggedIn.name, loggedIn);
  }

  T? getValueFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> setLocationLat({required double locationLat}) async {
    return  _sharedPreferences.setDouble(PrefKeys.locationLat.toString(), locationLat);
  }

  Future<bool> setLocationLong({required double locationLong}) async {
    return  _sharedPreferences.setDouble(PrefKeys.locationLong.toString(), locationLong);
  }

  Future<bool> setgoogleUserName({required String googleUserName}) async {
    return  _sharedPreferences.setString(PrefKeys.googleUserName.toString(), googleUserName);
  }

  Future<bool> setgoogleEmail({required String googleEmail}) async {
    return  _sharedPreferences.setString(PrefKeys.googleEmail.toString(), googleEmail);
  }

  Future<bool> changeLanguage({required String language}) async {
    return  _sharedPreferences.setString(PrefKeys.language.toString(), language);
  }


  Future<bool> removeValue({required String key}) async {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.remove(key);
    }
    return false;
  }

  void setDisplayOnBoarding(bool value) {
    _sharedPreferences.setBool(PrefKeys.displayOnBoarding.name, value);
  }

  bool getDisplayOnBoarding() {
    return _sharedPreferences.getBool(PrefKeys.displayOnBoarding.name) ?? true;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PrefKeys.loggedIn.name);
    _sharedPreferences.remove(PrefKeys.token.name);
    _sharedPreferences.remove(PrefKeys.email.name);
    _sharedPreferences.remove(PrefKeys.userName.name);
    _sharedPreferences.remove(PrefKeys.firstName.name);
    _sharedPreferences.remove(PrefKeys.lastName.name);
    _sharedPreferences.remove(PrefKeys.role.name);
    _sharedPreferences.remove(PrefKeys.telephone.name);
    _sharedPreferences.remove(PrefKeys.referralCode.name);
    _sharedPreferences.remove(PrefKeys.birthDate.name);
    _sharedPreferences.remove(PrefKeys.active.name);
    _sharedPreferences.remove(PrefKeys.ghafGold.name);
    _sharedPreferences.remove(PrefKeys.sellerSubmittedForm.name);
    _sharedPreferences.remove(PrefKeys.fcmToken.name);
    AppSharedData.currentUser = null;
  }
}
