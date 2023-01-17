import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddressWidget extends StatelessWidget {
  final Address address;
  final void Function()? onEditFinished;
  final void Function({
    required String addressId,
  })? onDeleteTapped;

  const AddressWidget({
    Key? key,
    required this.address,
    required this.onDeleteTapped,
    this.onEditFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        border: Border.all(width: AppSize.s1, color: ColorManager.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSize.s14,
          ),
          Text(
            address.addressName ?? '',
            style: getSemiBoldStyle(
              color: ColorManager.primaryDark,
              fontSize: FontSize.s16,
            ),
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Row(
            children: [
              Image.asset(
                IconsAssets.location1,
                height: AppSize.s15,
                width: AppSize.s11,
              ),
              SizedBox(
                width: AppSize.s8,
              ),
              Text(
                address.addressName ?? '',
                style: getRegularStyle(
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: AppSize.s10,
          // ),
          // Row(
          //   children: [
          //     Image.asset(
          //       IconsAssets.person,
          //       height: AppSize.s15,
          //       width: AppSize.s14,
          //     ),
          //     SizedBox(
          //       width: AppSize.s8,
          //     ),
          //     Text(
          //       address.addressName ?? '',
          //       style: getRegularStyle(
          //         color: ColorManager.black,
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: AppSize.s10,
          ),
          Row(
            children: [
              Image.asset(
                IconsAssets.call,
                height: AppSize.s18,
                width: AppSize.s18,
              ),
              SizedBox(
                width: AppSize.s8,
              ),
              Text(
                address.phone ?? '',
                style: getRegularStyle(
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    bool? result = (await Navigator.pushNamed(
                      context,
                      Routes.addOrEditAddressRoute,
                      arguments: address,
                    )) as bool?;
                    if (result != null && result) {
                      onEditFinished!();
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Color(0xff125051),
                      border: Border.all(
                        color: Color(0xff125051),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    onDeleteTapped!(addressId: address.id!);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Color(0xff125051),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.delete,
                        style: TextStyle(
                          color: Color(0xff125051),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s10,
          ),
        ],
      ),
    );
  }
}
