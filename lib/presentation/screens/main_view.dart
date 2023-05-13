import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/account_view/account_view.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_screen.dart';
import 'package:ghaf_application/presentation/screens/categories_view/categories_view_new.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/model/models.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'cart_view/cart_view.dart';
import 'categories_view/categories_view.dart';
import 'home_view/home_view.dart';
import 'login_view/login_view_getx_controller.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  List<BnScreen> testFun(BuildContext context) {
    return <BnScreen>[
      BnScreen(widget: HomeView(), title: AppLocalizations.of(context)!.home),
      BnScreen(
          widget: CategoriesViewNew(),
          title: AppLocalizations.of(context)!.categories),
      BnScreen(widget: CartScreen(), title: AppLocalizations.of(context)!.cart),
      BnScreen(
          widget: AccountView(), title: AppLocalizations.of(context)!.account),
    ];
  }
  // late final LoginViewGetXController _loginViewGetXController =
  // Get.put(LoginViewGetXController(context: context));

  @override
  void initState() {
    // _loginViewGetXController.login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductProvider(),
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: testFun(context)[_currentIndex].widget,
        ),
        bottomNavigationBar: SizedBox(
          height: AppSize.s73,
          child: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorManager.primary,
            selectedFontSize: FontSize.s16,
            unselectedFontSize: FontSize.s14,
            elevation: 30,
            selectedLabelStyle: getMediumStyle(
                color: ColorManager.primary, fontSize: FontSize.s12),
            unselectedLabelStyle: getMediumStyle(
                color: ColorManager.primary, fontSize: FontSize.s10),
            backgroundColor: ColorManager.white,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsAssets.home,
                  width: AppSize.s24,
                  height: AppSize.s20,
                ),
                activeIcon: Image.asset(
                  IconsAssets.home1,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsAssets.categories,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                activeIcon: Image.asset(
                  IconsAssets.categories1,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                label: AppLocalizations.of(context)!.categories,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsAssets.cart,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                activeIcon: Image.asset(
                  IconsAssets.cart1,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                label: AppLocalizations.of(context)!.cart,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsAssets.account,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                activeIcon: Image.asset(
                  IconsAssets.account1,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ),
                label: AppLocalizations.of(context)!.account,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
