import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/widgets/address_widget.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({Key? key}) : super(key: key);

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  // controller.
  late final AddressesViewGetXController _addressesViewGetXController =
      Get.find<AddressesViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<AddressesViewGetXController>();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    // print('===============================lat');
    // print(lat);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.my_address,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Divider(height: 1, color: ColorManager.greyLight),
              SizedBox(
                height: AppSize.s10,
              ),
              Expanded(
                child: GetBuilder<AddressesViewGetXController>(
                  id: 'isAddressesLoading',
                  builder: (controller) => controller.isAddressesLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        )
                      : _addressesViewGetXController.addresses.isEmpty
                          ? Center(
                              child: Text(
                                // 'No addresses found',
                                  AppLocalizations.of(context)!.no_addresses_found,
                              ),
                            )
                          : ListView.separated(
                              itemCount:
                                  _addressesViewGetXController.addresses.length,
                              separatorBuilder: (_, index) => SizedBox(
                                height: 5.h,
                              ),
                              itemBuilder: (_, index) => AddressWidget(
                                address: _addressesViewGetXController
                                    .addresses[index],
                                onEditFinished:
                                    _addressesViewGetXController.onEditFinished,
                                onDeleteTapped:
                                    _addressesViewGetXController.onDeleteTapped,
                              ),
                            ),
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () async {
                    bool? result = (await Navigator.pushNamed(
                        context, Routes.addOrEditAddressRoute)) as bool?;
                    if (result != null && result) {
                      _addressesViewGetXController.getMyAddresses(
                          notifyLoading: true);
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add_address,
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding aboutApp(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        children: [
          Text(
            title,
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s16,
            ),
          ),
          Spacer(),
          Transform(
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset(
              IconsAssets.arrow,
              height: AppSize.s18,
              width: AppSize.s10,
            ),
          ),
        ],
      ),
    );
  }
}
