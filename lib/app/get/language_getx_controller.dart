import 'package:get/get.dart';
import '../preferences/shared_pref_controller.dart';

class LanguageGetXController extends GetxController {
  static LanguageGetXController get to => Get.find<LanguageGetXController>();
  String language =
      SharedPrefController().lang1 ==
              null
          ? 'ar'
          : SharedPrefController()
              .lang1;

  void changeLanguage({required String language1}) {
    print('===========================language1');
    print(language);
    print('===========================language1');
    if (language1 == 'en') {
      language = 'en';
    }else if(language1 == 'ar' ) {
      language = 'ar';
    }
    print('===========================language2');
    print(language);
    print('===========================language2');
    // language.value = language.value == 'ar' ? 'en' : 'ar';
    SharedPrefController().changeLanguage(language: language);
    update();
  }
}
