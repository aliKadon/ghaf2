import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../checkout/check_out_getx_controller.dart';
import '../checkout/order_tracking_screen.dart';
import 'controller/help_getx_controller.dart';

class ReportAnotherIssueScreen extends StatefulWidget {
  String? orderId;
  String? name;
  String? imageUrl;

  ReportAnotherIssueScreen({this.orderId, this.name, this.imageUrl});

  @override
  State<ReportAnotherIssueScreen> createState() =>
      _ReportAnotherIssueScreenState();
}

class _ReportAnotherIssueScreenState extends State<ReportAnotherIssueScreen>
    with Helpers {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  late final HelpGetxController _helpGetxController =
      Get.put(HelpGetxController());

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getOrderById(
        context: context, orderId: widget.orderId!);
    super.initState();
  }

  var selected = -1;

  @override
  Widget build(BuildContext context) {
    List returnType = [
      AppLocalizations.of(context)!.get_help_reporting_issue1,
      AppLocalizations.of(context)!.get_help_reporting_issue2,
      AppLocalizations.of(context)!.get_help_reporting_issue3,
    ];
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSize.s6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.get_help,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Divider(
                thickness: 1,
                color: ColorManager.greyLight,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    widget.imageUrl == null || widget.imageUrl == ''
                        ? Container(
                      height: AppSize.s110,
                      width: AppSize.s110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.pizza))),
                    )
                        : Container(
                      height: AppSize.s110,
                      width: AppSize.s110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(widget.imageUrl!))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w500),
                        ),
                        // SizedBox(
                        //   height: AppSize.s14,
                        // ),
                        // Text(
                        //   'ordered on 9 dec 2022',
                        //   style: TextStyle(
                        //       color: ColorManager.greyLight,
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: FontSize.s14),
                        // ),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => OrderTrackingScreen(
                                  orderId: widget.orderId!,
                                  source: _checkOutGetxController
                                      .order!.deliveryPoint!,
                                  destination: _checkOutGetxController
                                      .order!.branch!.branchAddress!),
                            ));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.review_order,
                            style: TextStyle(
                                color: ColorManager.primaryDark,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Text(
                AppLocalizations.of(context)!.why_are_you_reporting_this,
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s18),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: returnType.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: selected == index
                        ? ReturnOrderType(
                            context,
                            returnType[index],
                            Icons.radio_button_on_outlined,
                            ColorManager.primary)
                        : ReturnOrderType(context, returnType[index],
                            Icons.radio_button_off, ColorManager.greyLight),
                  );
                },
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Container(
                  child: AppTextField(
                      textController: _textEditingController,
                      lines: 4,
                      hint: AppLocalizations.of(context)!
                          .get_help_reporting_issue4)),
              SizedBox(
                height: AppSize.s24,
              ),
              Container(
                height: AppSize.s44,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _helpGetxController.reportGeneralIssueTicket(
                          context: context,
                          comment: returnType[selected] ==
                                  AppLocalizations.of(context)!
                                      .get_help_reporting_issue3
                              ? 'other : ${_textEditingController.text}'
                              : returnType[selected]);
                    },
                    child: Text(AppLocalizations.of(context)!.confirm)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ReturnOrderType(BuildContext context, String text, IconData iconData,
      Color colorManager) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: colorManager,
            ),
            SizedBox(
              width: AppSize.s14,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(text,
                  style: TextStyle(
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s16)),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s14,
        ),
      ],
    );
  }
}
