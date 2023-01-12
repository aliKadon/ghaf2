import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/account_view/account_view.dart';
import 'package:ghaf_application/presentation/screens/notification_view.dart';
import 'package:ghaf_application/presentation/screens/seller/add_item2_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/add_item_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/products_with_out_details_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/store_seller_view.dart';

import '../../../domain/model/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class MainSellerView extends StatefulWidget {
  const MainSellerView({Key? key}) : super(key: key);

  @override
  State<MainSellerView> createState() => _MainSellerViewState();
}

class _MainSellerViewState extends State<MainSellerView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  List<BnScreen> testFun(BuildContext context) {
    return <BnScreen>[
      BnScreen(
          widget: ProductsWithOutDetailsSellerView(),
          title: AppLocalizations.of(context)!.new_order),
      // BnScreen(
      //     widget: NotificationView(),
      //     title: AppLocalizations.of(context)!.notifications),
      BnScreen(
          widget: AddItemSellerView(false),
          title: AppLocalizations.of(context)!.store),
      BnScreen(
          widget: StoreSellerView(), title: AppLocalizations.of(context)!.account),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
          selectedFontSize: 16,
          unselectedFontSize: 14,
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
                IconsAssets.newOrder,
                width: AppSize.s24,
                height: AppSize.s24,
              ),
              activeIcon: Image.asset(
                IconsAssets.newOrder1,
                width: AppSize.s24,
                height: AppSize.s24,
              ),
              label: AppLocalizations.of(context)!.new_order,
            ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(
            //     IconsAssets.notification,
            //     width: AppSize.s24,
            //     height: AppSize.s24,
            //   ),
            //   activeIcon: Image.asset(
            //     IconsAssets.notification1,
            //     width: AppSize.s24,
            //     height: AppSize.s24,
            //   ),
            //   label: AppLocalizations.of(context)!.notifications,
            // ),
            BottomNavigationBarItem(
              icon: Image.asset(
                IconsAssets.store,
                width: AppSize.s24,
                height: AppSize.s24,
              ),
              activeIcon: Image.asset(
                IconsAssets.store1,
                width: AppSize.s24,
                height: AppSize.s24,
              ),
              label: AppLocalizations.of(context)!.store,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                IconsAssets.settings,
                width: AppSize.s24,
                height: AppSize.s24,
              ),
              activeIcon: Image.asset(
                IconsAssets.settings1,
                width: AppSize.s24,
                height: AppSize.s24,
              ),
              label: AppLocalizations.of(context)!.account,
            ),
          ],
        ),
      ),
    );
  }
}
