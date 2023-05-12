import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../app/utils/app_shared_data.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../addresses_view/addresses_view_getx_controller.dart';

class AddressHome extends StatefulWidget {
  @override
  State<AddressHome> createState() => _AddressHomeState();
}

class _AddressHomeState extends State<AddressHome> {
  //controller
  // late final CheckOutGetxController _checkOutGetxController =
  //     Get.find<CheckOutGetxController>();
  late final CheckOutGetxController _checkOutGetxController =
  Get.put(CheckOutGetxController());
  late final AddressesViewGetXController _addressesViewGetXController =
  Get.put(AddressesViewGetXController(context: context));

  var selectedAddress;
  var isSelectedDelivery = true;

  @override
  void initState() {
    // TODO: implement initState
    _addressesViewGetXController.getMyAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            )),
        title: Text(AppLocalizations.of(context)!.address),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.addressesRoute);
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddressesView(),));
            },
              child: Container(
                width: AppSize.s35,
                child: Icon(
            Icons.add_circle_outline,
            color: ColorManager.primary,
          ),
              ))
        ],
      ),
      body: GetBuilder<AddressesViewGetXController>(
        id: 'isAddressesLoading',
        builder: (controller) => controller.addresses.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_addresses_found,
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w500)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddressesView(),
                          ));
                        },
                        child: Text(AppLocalizations.of(context)!.add_address))
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: controller.addresses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = index;
                          _checkOutGetxController.getDurationGoogleMap(
                              LatOne: SharedPrefController().locationLat,
                              LonOne: SharedPrefController().locationLong,
                              LatTow: double.parse(controller
                                  .addresses[selectedAddress]!.altitude!),
                              LonTow: double.parse(controller
                                  .addresses[selectedAddress]!.longitude!));
                        });
                        Navigator.of(context).pop({
                          'addressName':
                              controller.addresses[selectedAddress].addressName,
                          'long':
                              controller.addresses[selectedAddress].longitude,
                          'lat': controller.addresses[selectedAddress].altitude,
                        });
                      },
                      child: Visibility(
                        visible: isSelectedDelivery,
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppSize.s12,
                            ),
                            selectedAddress == index
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppPadding.p8),
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      border: Border.all(
                                          width: AppSize.s1,
                                          color: ColorManager.grey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: AppSize.s14,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.addresses[index]
                                                  .addressName!,
                                              style: getSemiBoldStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppSize.s10,
                                        ),
                                        Row(children: [
                                          Image.asset(
                                            IconsAssets.location2,
                                            height: AppSize.s15,
                                            width: AppSize.s11,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            controller
                                                .addresses[index].cityName!,
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s10,
                                        ),
                                        Row(children: [
                                          Image.asset(
                                            IconsAssets.person,
                                            height: AppSize.s15,
                                            width: AppSize.s14,
                                            color: ColorManager.primaryDark,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            '${AppSharedData.currentUser?.firstName}',
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s10,
                                        ),
                                        Row(children: [
                                          Image.asset(
                                            IconsAssets.call2,
                                            height: AppSize.s18,
                                            width: AppSize.s18,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            controller.addresses[index].phone!,
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s22,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppPadding.p8),
                                    decoration: BoxDecoration(
                                      // color: ColorManager.primary,
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      border: Border.all(
                                          width: AppSize.s1,
                                          color: ColorManager.grey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: AppSize.s14,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.addresses[index]
                                                  .addressName!,
                                              style: getSemiBoldStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                            Spacer(),
                                            Visibility(
                                              visible: false,
                                              child: Icon(
                                                Icons.check_circle,
                                                color: Colors.lightGreenAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppSize.s10,
                                        ),
                                        Row(children: [
                                          Image.asset(
                                            IconsAssets.location1,
                                            height: AppSize.s15,
                                            width: AppSize.s11,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            controller
                                                .addresses[index].cityName!,
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s10,
                                        ),
                                        Row(children: [
                                          Image.asset(
                                            IconsAssets.person,
                                            height: AppSize.s15,
                                            width: AppSize.s14,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            '${AppSharedData.currentUser?.firstName}',
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s10,
                                        ),
                                        Row(children: [
                                          Image.asset(
                                            IconsAssets.call,
                                            height: AppSize.s18,
                                            width: AppSize.s18,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            controller.addresses[index].phone!,
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s22,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
