import 'package:get/get.dart';
import '../preferences/shared_pref_controller.dart';

class LanguageGetXController extends GetxController {
  static LanguageGetXController get to => Get.find<LanguageGetXController>();
  String language = SharedPrefController().lang1;

  void changeLanguage({required String language1}) {
    print('===========================language1');
    print(language);
    print('===========================language1');
    // if (language1 == 'en') {
    //   language = 'en';
    // }else if(language1 == 'ar' ) {
    //   language = 'ar';
    // }
    language = language1 == 'ar' ? 'ar' : 'en';
    print('===========================language2');
    print(language);
    print('===========================language2');

    SharedPrefController().changeLanguage(language: language);
    update();
  }
}
