import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/providers/category_provider.dart';
import 'package:ghaf_application/providers/language_provider.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'L10n.dart';
import 'get/language_getx_controller.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageGetXController languageGetXController =
  Get.put<LanguageGetXController>(LanguageGetXController());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SellerProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocaleProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          print(provider.locale);

          var isArabic = SharedPrefController().lang1;
          print('isArabic : $isArabic');
          print(languageGetXController.language);

          return GetBuilder<LanguageGetXController>(
              builder: (controller) {
                print('isArabic : $isArabic');
                print(languageGetXController.language);
                return GetMaterialApp(
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: L10n.all,
                  locale: Locale(controller.language),
                  // locale: provider.locale,
                  builder: DevicePreview.appBuilder,
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: RouteGenerator.getRoute,
                  initialRoute: Routes.splashRoute,
                  // home: HomeView(),
                  theme: getApplicationTheme(),
                );
              }
          );
        },
      ),
    );
  }
}
