import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/get_help/controller/help_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_issue_with_order_Screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/model/address.dart';
import '../../../domain/model/order.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OrderTrackingSchedualScreen extends StatefulWidget {
  final String orderId;
  final Address source;
  final Address destination;

  OrderTrackingSchedualScreen(
      {required this.orderId, required this.source, required this.destination});

  @override
  State<OrderTrackingSchedualScreen> createState() =>
      _OrderTrackingSchedualScreenState();
}

class _OrderTrackingSchedualScreenState
    extends State<OrderTrackingSchedualScreen> with Helpers {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  late final AddressesViewGetXController _addressesViewGetXController =
      Get.put(AddressesViewGetXController(context: context));
  final HelpGetxController _helpGetxController = Get.put(HelpGetxController());

  var textSetuaition = '';

  var isLoadingColor = true;

  var isLoading1 = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      isLoading1 = false;
    });
    getPolyPoints(
        LatLng(double.parse(widget.source.altitude!),
            double.parse(widget.source.longitude!)),
        LatLng(double.parse(widget.destination.altitude!),
            double.parse(widget.destination.longitude!)));
    _checkOutGetxController.getSchedualOrderById(
        context: context, id: widget.orderId);
    print('=====================statusName!');
    // print(_checkOutGetxController.order!.statusName!);

    _checkOutGetxController.getDurationGoogleMap(
        LatOne: double.parse(widget.source.altitude!),
        LonOne: double.parse(widget.source.longitude!),
        LatTow: double.parse((widget.destination.altitude!)),
        LonTow: double.parse(widget.destination.longitude!));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('========================did change');

    if (_checkOutGetxController.order != null) {}
    super.didChangeDependencies();
  }

  var isLoading = true;
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? locationData;
  LocationData? distination;

  final Completer<GoogleMapController> _controller = Completer();

  // late LatLng destination;
  static LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static LatLng destination1 = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];

  LatLng source = LatLng(24.450927886780995, 55.602918476617994);
  LatLng destination = LatLng(24.430927886780995, 55.622918476617994);

  Future<void> getPolyPoints(LatLng source, LatLng destination) async {
    print('=========================location1');

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.google_key_map, // Your Google Map Key
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    print('=================================points');
    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
        print('==============================point');
        print(point.latitude);
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('==============================status');

    if (_checkOutGetxController.scheduleOrderById != null) {}
    return Scaffold(
      body: GetBuilder<CheckOutGetxController>(builder: (controller) {
              return SafeArea(
                child: controller.isLoadingScheduleOrderById
                    ? Center(
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(AppPadding.p16),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, Routes.mainRoute),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.038,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Image.asset(
                                          SharedPrefController().lang1 == 'ar'
                                              ? IconsAssets.arrow2
                                              : IconsAssets.arrow,
                                          height: AppSize.s18,
                                          width: AppSize.s10,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      AppLocalizations.of(context)!.track_order,
                                      style: getSemiBoldStyle(
                                        color: ColorManager.primaryDark,
                                        fontSize: FontSize.s18,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Divider(
                                    height: 2, color: ColorManager.greyLight),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: isLoading
                                      ? Center(
                                          child: Container(
                                            width: 20.h,
                                            height: 20.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(AppSize.s10),
                                          child: GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(
                                                  double.parse(
                                                      widget.source.altitude!),
                                                  double.parse(widget
                                                      .source.longitude!)),
                                              zoom: 12.5,
                                            ),
                                            markers: {
                                              Marker(
                                                markerId: MarkerId("source"),
                                                position: LatLng(
                                                    double.parse(widget
                                                        .source.altitude!),
                                                    double.parse(widget
                                                        .source.longitude!)),
                                              ),
                                              Marker(
                                                markerId:
                                                    MarkerId("destination"),
                                                position: LatLng(
                                                    double.parse(widget
                                                        .destination.altitude!),
                                                    double.parse(widget
                                                        .destination
                                                        .longitude!)),
                                              ),
                                            },
                                            onMapCreated: (mapController) {
                                              _controller
                                                  .complete(mapController);
                                            },
                                            polylines: {
                                              Polyline(
                                                polylineId:
                                                    const PolylineId("route"),
                                                points: polylineCoordinates,
                                                color: const Color(0xFF7B61FF),
                                                width: 3,
                                              ),
                                            },
                                          ),
                                        ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .estimated_delivery_time,
                                  style: TextStyle(
                                      fontSize: FontSize.s18,
                                      color: ColorManager.primaryDark,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  controller.duration.toString() ??
                                      AppLocalizations.of(context)!
                                          .calculate_time,
                                  style: TextStyle(
                                      fontSize: FontSize.s18,
                                      color: ColorManager.primary),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: AppSize.s16,
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .order_Number,
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s16,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${AppLocalizations.of(context)!.branch_name}',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '# ${controller.scheduleOrderById?.sequenceNumber}',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s16,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${controller.scheduleOrderById?.branch?.branchName}',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .order_summary,
                                        style: getSemiBoldStyle(
                                          color: ColorManager.primaryDark,
                                          fontSize: FontSize.s16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(AppSize.s8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: ColorManager.greyLight,
                                    ),
                                  ),
                                  // margin: EdgeInsets.only(
                                  //     bottom: AppMargin.m16,
                                  //     right: AppMargin.m16,
                                  //     left: AppMargin.m16),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.scheduleOrderById?.items!.length,
                                    itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'X ${ controller.scheduleOrderById?.items![index].quanity}',
                                              style: getSemiBoldStyle(
                                                color: ColorManager.grey,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '${controller.scheduleOrderById?.items![index].name}',
                                              style: getSemiBoldStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                            SizedBox(height: AppSize.s8,)
                                          ],
                                        ),
                                      ],
                                    );
                                  },)
                                ),
                                SizedBox(height: AppSize.s12,),
                                Container(
                                  padding: EdgeInsets.all(AppSize.s8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: ColorManager.greyLight,
                                    ),
                                  ),
                                  // margin: EdgeInsets.only(
                                  //     bottom: AppMargin.m16,
                                  //     right: AppMargin.m16,
                                  //     left: AppMargin.m16),
                                  child: Column(
                                    children: [

                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.total,
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s16,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${(controller.scheduleOrderById?.totalCostForItems)} ${AppLocalizations.of(context)!.aed}',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.address,
                                        style: getSemiBoldStyle(
                                          color: ColorManager.primaryDark,
                                          fontSize: FontSize.s16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p8),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
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
                                          GetBuilder<
                                              AddressesViewGetXController>(
                                            builder: (controller2) => Text(
                                              controller.scheduleOrderById!.deliveryPoint
                                                          ?.cityName !=
                                                      null
                                                  ? '${controller.scheduleOrderById!.deliveryPoint?.cityName}'
                                                  : controller2.addresses
                                                              .length !=
                                                          0
                                                      ? '${controller2.addresses[0].addressName}'
                                                      : '${SharedPrefController().city}',
                                              style: getSemiBoldStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Visibility(
                                            visible: false,
                                            child: Icon(
                                              Icons.check_circle,
                                              color: Colors.lightGreenAccent,
                                            ),
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      GetBuilder<AddressesViewGetXController>(
                                        builder: (controller1) =>
                                            Row(children: [
                                          Image.asset(
                                            IconsAssets.location,
                                            height: AppSize.s15,
                                            width: AppSize.s11,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            controller.scheduleOrderById!.deliveryPoint
                                                        ?.cityName !=
                                                    null
                                                ? '${controller.scheduleOrderById!.deliveryPoint?.cityName}'
                                                : controller1
                                                            .addresses.length !=
                                                        0
                                                    ? '${controller1.addresses[0].addressName}'
                                                    : '${SharedPrefController().city}',
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      // Row(children: [
                                      //   Image.asset(
                                      //     IconsAssets.person,
                                      //     height: AppSize.s15,
                                      //     width: AppSize.s14,
                                      //   ),
                                      //   SizedBox(
                                      //     width: AppSize.s8,
                                      //   ),
                                      //   Text(
                                      //     'zidan zidan',
                                      //     style: getRegularStyle(
                                      //       color: ColorManager.black,
                                      //     ),
                                      //   ),
                                      // ]),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      GetBuilder<AddressesViewGetXController>(
                                        builder: (controller3) =>
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
                                            controller.scheduleOrderById!.deliveryPoint
                                                        ?.cityName !=
                                                    null
                                                ? '${controller.scheduleOrderById!.deliveryPoint?.phone}'
                                                : controller3
                                                            .addresses.length !=
                                                        0
                                                    ? '${controller3.addresses[0].phone}'
                                                    : '0',
                                            style: getRegularStyle(
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: AppSize.s22,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            // canLaunchUrl('tel://+1234567890'),
                                            // await call(
                                            //     Telephone: widget.orderId['branch']
                                            //         ['telephone']);
                                            _callShopDialog(
                                                context,
                                                controller
                                                    .scheduleOrderById!.branch!.telephone!);
                                          },
                                          child: Container(
                                            width: AppSize.s60,
                                            height: AppSize.s110,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  IconsAssets.call2,
                                                  color: Colors.white,
                                                  height: AppSize.s22,
                                                  width: AppSize.s22,
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .call_shop,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: FontSize.s10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            _helpGetxController.cancelOrder(
                                                context: context,
                                                id: _checkOutGetxController
                                                    .order!.id!);
                                            // showSheet(context);
                                            // canLaunchUrl('tel://+1234567890'),
                                            // await call(
                                            //     Telephone: widget.orderId['branch']
                                            //         ['telephone']);
                                          },
                                          child: Container(
                                            width: AppSize.s60,
                                            height: AppSize.s110,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  ImageAssets.x,
                                                  color: Colors.white,
                                                  height: AppSize.s22,
                                                  width: AppSize.s22,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .cancel_order,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            _helpGetxController.requestCallBack(
                                                context: context,
                                                bid: _checkOutGetxController
                                                    .scheduleOrderById!.branch!.id!);
                                            // canLaunchUrl('tel://+1234567890'),
                                            // await call(
                                            //     Telephone: widget.orderId['branch']
                                            //         ['telephone']);
                                          },
                                          child: Container(
                                            width: AppSize.s60,
                                            height: AppSize.s110,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Image.asset(
                                                //   IconsAssets.call2,
                                                //   color: Colors.white,
                                                //   height: AppSize.s22,
                                                //   width: AppSize.s22,
                                                // ),
                                                Icon(
                                                  Icons.phone_callback,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .request_call_back,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReportIssueWithOrderScreen(
                                                        name:
                                                            _checkOutGetxController
                                                                .scheduleOrderById!
                                                                .items![0]
                                                                .name!,
                                                        orderId:
                                                            _checkOutGetxController
                                                                .scheduleOrderById!.id,
                                                        productId:
                                                            _checkOutGetxController
                                                                .scheduleOrderById!
                                                                .items![0]
                                                                .id,
                                                      )));
                                          // await whatsapp(
                                          //     phone: widget.orderId['branch']
                                          //         ['branchAddress']['phone']);
                                          // whatsapp(phone: '00971559075423423');
                                        },
                                        child: Container(
                                          width: AppSize.s60,
                                          height: AppSize.s110,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                ImageAssets.vector,
                                                color: Colors.white,
                                                height: AppSize.s22,
                                                width: AppSize.s22,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .report_an_issue,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: FontSize.s10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                // _checkOutGetxController.order!.statusName == 'Done'
                                //     ? Container(
                                //         child: ElevatedButton(
                                //             onPressed: () {
                                //               _customDialogFeedBack(context,
                                //                   _checkOutGetxController.order!);
                                //               // Navigator.of(context).pushReplacementNamed(
                                //               //     Routes.reviewProduct,
                                //               //     arguments: widget.orderId);
                                //             },
                                //             child: Text(AppLocalizations.of(context)!
                                //                 .feed_back)),
                                //       )
                                //     : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            }),
    );
  }

  void _customDialogFeedBack(context, Order orderById1) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s326,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.feed_back,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    Padding(
                      padding: EdgeInsets.all(AppSize.s10),
                      child: Text(
                        AppLocalizations.of(context)!.tell_experience,
                        style: TextStyle(fontSize: AppSize.s18),
                      ),
                    ),

                    SizedBox(
                      height: AppSize.s10,
                    ),

                    // SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.rateSeller);
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.with_Seller,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.rateDelivery,
                                arguments: orderById1.driverId);
                          },
                          child: orderById1.deliveryMethod.methodName ==
                                      'Pick up' ||
                                  orderById1.deliveryMethod.methodName ==
                                      'Car window'
                              ? Container()
                              : orderById1.driverId == null
                                  ? Container()
                                  : Container(
                                      width: AppSize.s110,
                                      height: AppSize.s38,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorManager.primaryDark,
                                        borderRadius:
                                            BorderRadius.circular(AppRadius.r8),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .with_driver,
                                        textAlign: TextAlign.center,
                                        style: getMediumStyle(
                                            color: ColorManager.white),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.ok)),
                    ),
                  ]),
            ),
          );
        });
  }

  void _callShopDialog(BuildContext context, String telephone) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              // top: 0,
              bottom: 0,
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  // color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(AppSize.s8),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  child: Column(
                    children: [
                      Container(
                        height: AppSize.s44,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _contactPhoneNumber(telephone);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: AppSize.s30,
                                ),
                                Icon(
                                  Icons.phone,
                                  color: ColorManager.primaryDark,
                                ),
                                Spacer(),
                                Text(
                                  telephone,
                                  style: TextStyle(
                                      color: ColorManager.primaryDark),
                                ),
                                Spacer(),
                              ],
                            )),
                      ),
                      SizedBox(height: AppSize.s22),
                      Container(
                        height: AppSize.s44,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(color: ColorManager.primaryDark),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  whatsapp({required String phone}) async {
    final url;

    if (phone.length >= 12) {
      url = "whatsapp://send?phone=$phone";
    } else if (phone.length == 8) {
      url = "whatsapp://send?phone=00971${phone.substring(1)}";
    } else {
      url = "whatsapp://send?phone=00971${phone}";
    }

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  call({required String Telephone}) async {
    final url = "tel://$Telephone";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // open phone number in mobile
  void _contactPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
