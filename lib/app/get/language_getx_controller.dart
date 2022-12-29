import 'package:get/get.dart';
import '../preferences/shared_pref_controller.dart';

class LanguageGetXController extends GetxController {
  static LanguageGetXController get to => Get.find<LanguageGetXController>();
  Rx<String> language =
      SharedPrefController().getValueFor<String>(key: PrefKeys.lang.name) ==
              null
          ? 'ar'.obs
          : SharedPrefController()
              .getValueFor<String>(key: PrefKeys.lang.name)!
              .obs;

  void changeLanguage() {
    language.value = language.value == 'ar' ? 'en' : 'ar';
    SharedPrefController().changeLanguage(language: language.value);
    update();
  }
}
