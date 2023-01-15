import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';


import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  OrderTrackingScreen(this.orderId);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  Color color1 = ColorManager.primary;
  Color color2 = Colors.green;
  Color color3 = Colors.green;
  Color color4 = Colors.green;

  Color cIcon1 = Colors.green;
  Color cIcon2 = Colors.green;
  Color cIcon3 = Colors.green;
  Color cIcon4 = Colors.green;

  var textSetuaition = '';

  void getColorBackground(String statusName) {
    if (statusName == 'Intialized' ||
        statusName == 'NotAssignedToEmployee' ||
        statusName == 'UnPaid' ||
        statusName == 'Paid') {
      setState(() {
        color1 = ColorManager.primaryDark;
        color2 = ColorManager.white;
        color3 = ColorManager.white;
        color4 = ColorManager.white;
      });
    } else if (statusName == 'AssignedToEmployee' ||
        statusName == 'NotAssignedToDriver') {
      setState(() {
        color2 = ColorManager.primaryDark;
        color1 = ColorManager.white;
        color3 = ColorManager.white;
        color4 = ColorManager.white;
      });
    } else if (statusName == 'ReadyForDriver' ||
        statusName == 'AssignedToDriver' ||
        statusName == 'OnWay') {
      setState(() {
        color3 = ColorManager.primaryDark;
        color2 = ColorManager.white;
        color1 = ColorManager.white;
        color4 = ColorManager.white;
      });
    } else if (statusName == 'Done') {
      setState(() {
        color4 = ColorManager.primaryDark;
        color2 = ColorManager.white;
        color3 = ColorManager.white;
        color1 = ColorManager.white;
      });
    }
  }

  void getColorIcon(String statusName) {
    if (statusName == 'Intialized' ||
        statusName == 'NotAssignedToEmployee' ||
        statusName == 'UnPaid' ||
        statusName == 'Paid') {
      setState(() {
        cIcon1 = ColorManager.white;
        cIcon2 = ColorManager.primary;
        cIcon3 = ColorManager.primary;
        cIcon4 = ColorManager.primary;
      });
    } else if (statusName == 'AssignedToEmployee' ||
        statusName == 'NotAssignedToDriver') {
      setState(() {
        cIcon2 = ColorManager.white;
        cIcon1 = ColorManager.primary;
        cIcon3 = ColorManager.primary;
        cIcon4 = ColorManager.primary;
      });
    } else if (statusName == 'ReadyForDriver' ||
        statusName == 'AssignedToDriver' ||
        statusName == 'OnWay') {
      setState(() {
        cIcon3 = ColorManager.white;
        cIcon2 = ColorManager.primary;
        cIcon1 = ColorManager.primary;
        cIcon4 = ColorManager.primary;
      });
    } else if (statusName == 'Done') {
      setState(() {
        cIcon4 = ColorManager.white;
        cIcon2 = ColorManager.primary;
        cIcon3 = ColorManager.primary;
        cIcon1 = ColorManager.primary;
      });
    }
  }

  void getTextSetuaition(String statusName) {
    if (statusName == 'Intialized' ||
        statusName == 'NotAssignedToEmployee' ||
        statusName == 'UnPaid' ||
        statusName == 'Paid') {
      setState(() {
        textSetuaition = 'Great, You have an Order now! ';
      });
    } else if (statusName == 'AssignedToEmployee' ||
        statusName == 'NotAssignedToDriver') {
      setState(() {
        textSetuaition = ' staff are processing the order! ';
      });
    } else if (statusName == 'ReadyForDriver' ||
        statusName == 'AssignedToDriver' ||
        statusName == 'OnWay') {
      setState(() {
        textSetuaition = 'This order is with a driver and on the way! ';
      });
    } else if (statusName == 'Done') {
      setState(() {
        textSetuaition = 'Congrats, Your Order is deliveried! ';
      });
    }
  }

  @override
  void initState() {
    // getPolyPoints(double.parse(Provider
    //     .of<ProductProvider>(context, listen: false)
    //     .orderById['deliveryPoint']['altitude']),
    //     double.parse(Provider
    //         .of<ProductProvider>(context, listen: false)
    //         .orderById['deliveryPoint']['longitude'] ), double.parse(Provider
    //         .of<ProductProvider>(context, listen: false)
    //         .orderById['branch']['branchAddress']['altitude']), double.parse(Provider
    //         .of<ProductProvider>(context, listen: false)
    //         .orderById['branch']['branchAddress']['altitude']));
    Provider.of<ProductProvider>(context, listen: false).getUnpaidOrder();
    Provider.of<ProductProvider>(context, listen: false)
        .getOrderById(widget.orderId)
        .then((value) => getLocation())
        .then((value) =>
        getPolyPoints(
            Provider
                .of<ProductProvider>(context, listen: false)
                .orderById))
        .then((value) =>
        getColorBackground(
            Provider
                .of<ProductProvider>(context, listen: false)
                .orderById['statusName']))
        .then((value) =>
        getColorIcon(
            Provider
                .of<ProductProvider>(context, listen: false)
                .orderById['statusName']))
        .then((value) =>
        getTextSetuaition(
            Provider
                .of<ProductProvider>(context, listen: false)
                .orderById['statusName']))
        .then((value) =>
        Provider.of<ProductProvider>(context, listen: false)
            .getDurationGoogleMap(
          LatOne: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['deliveryPoint']['altitude']),
          LonOne: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['deliveryPoint']['longitude']),
          LatTow: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['branch']['branchAddress']['altitude']),
          LonTow: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['branch']['branchAddress']['longitude']),
        ));

    // Provider.of<ProductProvider>(context, listen: false).getDurationGoogleMap(
    //   LatOne: 37.33500926,
    //   LonOne: -122.03272188,
    //   LatTow: 37.33429383,
    //   LonTow: -122.06600055,
    // );
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   Provider.of<ProductProvider>(context, listen: false)
  //       .getOrderById(widget.orderId)
  //       .then((value) => getLocation())
  //       .then((value) =>
  //       Provider.of<ProductProvider>(context, listen: false)
  //           .getDurationGoogleMap(
  //         LatOne: double.parse(
  //             Provider
  //                 .of<ProductProvider>(context, listen: false)
  //                 .orderById['deliveryPoint']['altitude'] ??
  //                 locationData!.latitude),
  //         LonOne: double.parse(
  //             Provider
  //                 .of<ProductProvider>(context, listen: false)
  //                 .orderById['deliveryPoint']['longitude'] ??
  //                 locationData!.longitude),
  //         LatTow: double.parse(
  //             Provider
  //                 .of<ProductProvider>(context, listen: false)
  //                 .orderById['branch']['branchAddress']['altitude'] ??
  //                 locationData!.latitude),
  //         LonTow: double.parse(
  //             Provider
  //                 .of<ProductProvider>(context, listen: false)
  //                 .orderById['branch']['branchAddress']['longitude'] ??
  //                 locationData!.longitude),
  //       ))
  //       .then((value) =>
  //       getColorBackground(
  //           Provider
  //               .of<ProductProvider>(context, listen: false)
  //               .orderById['statusName']))
  //       .then((value) =>
  //       getColorIcon(
  //           Provider
  //               .of<ProductProvider>(context, listen: false)
  //               .orderById['statusName']))
  //       .then((value) =>
  //       getTextSetuaition(Provider
  //           .of<ProductProvider>(context, listen: false)
  //           .orderById['statusName']))
  //       .then((value) => isLoading = false);
  //   super.didChangeDependencies();
  // }

  //
  // static LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  // static LatLng destination1 = LatLng(37.33429383, -122.06600055);

  var isLoading = true;
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? locationData;
  LocationData? distination;

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    if (locationData != null) {
      isLoading = false;
    }
    print('===========================location');
    print(locationData!.latitude);
    print(widget.orderId);
  }

  // LocationData locationData = await location.getLocation();

  final Completer<GoogleMapController> _controller = Completer();

  // late LatLng destination;
  static LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static LatLng destination1 = LatLng(37.33429383, -122.06600055);

  // destination = LatLng(locationData!.latitude!, locationData!.latitude!);

  // final url = "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey";
  //
  // final response = await http.get(url);
  // final data = json.decode(response.body);
  //
  // final distance = data["routes"][0]["legs"][0]["distance"]["text"];
  // final duration = data["routes"][0]["legs"][0]["duration"]["text"];

  // List<LatLng> polylineCoordinates = [];
  //
  // void getPolyPoints(Map<String,dynamic> source) async {
  //   // Timer(Duration(seconds: 7), () async {
  //     print('=========================location1');
  //     print(source['deliveryPoint']['altitude']);
  //     print(source['branch']['branchAddress']['altitude']);
  //     // setState(() {
  //     //
  //     // });
  //     PolylinePoints polylinePoints = PolylinePoints();
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       Constants.google_key_map, // Your Google Map Key
  //       // PointLatLng(
  //       //     widget.orderinfo['deliveryPoint']['latitude'] ??
  //       //         locationData!.latitude!,
  //       //     widget.orderinfo['deliveryPoint']['longitude'] ??
  //       //         locationData!.longitude!),
  //       // PointLatLng(
  //       //     widget.orderinfo['branchAddress']['latitude'] ??
  //       //         destination1.latitude,
  //       //     widget.orderinfo['branchAddress']['longitude'] ??
  //       //         destination1.longitude),
  //       PointLatLng(double.parse(source['deliveryPoint']['altitude']),
  //           double.parse(source['deliveryPoint']['longitude'])),
  //       PointLatLng(
  //           double.parse(source['branch']['branchAddress']['altitude']), double.parse(source['branch']['branchAddress']['altitude'])),
  //       // PointLatLng(locationData!.latitude!, locationData!.latitude!),
  //     );
  //     if (result.points.isNotEmpty) {
  //       result.points.forEach(
  //             (PointLatLng point) => polylineCoordinates.add(
  //           LatLng(point.latitude, point.longitude),
  //         ),
  //       );
  //       setState(() {});
  //     }
  //   // },
  //   // );
  // }

  late var lat = Provider
      .of<ProductProvider>(context, listen: false)
      .orderById['deliveryPoint']['altitude'];

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints(Map<String, dynamic> source) async {
    print('=========================location1');
    // print(source['deliveryPoint']['altitude']);
    // print(source['branch']['branchAddress']['altitude']);
    var sourcelat;
    var sourcLong;
    var destLat;
    var destLong;

    if (source['deliveryPoint'] == null ||
        source['branch']['branchAddress']['altitude'] == null) {
      // sourcelat =  24.242978478140152;
      sourcelat = locationData!.latitude!;
      // sourcLong =  54.710762053728104;
      sourcLong = locationData!.longitude;
      // destLat =  24.942449826993236;
      destLat = locationData!.latitude;
      // destLong = 55.08180757318326;
      destLong = locationData!.longitude;
    } else {
      sourcelat = double.parse(source['deliveryPoint']['altitude']);
      sourcLong = double.parse(source['deliveryPoint']['longitude']);
      destLat = double.parse(source['branch']['branchAddress']['altitude']);
      destLong = double.parse(source['branch']['branchAddress']['longitude']);
    }
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.google_key_map, // Your Google Map Key
        // PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        // PointLatLng(destination.latitude, destination.longitude),

        // PointLatLng(24.242978478140152,
        //     54.710762053728104),
        // PointLatLng(
        //     24.942449826993236, 55.08180757318326)

        PointLatLng(sourcelat, sourcLong),
        PointLatLng(destLat, destLong));

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

  // void getOrderLocationToreview(LocationData currentLocation,
  //     LocationData distanation1) {
  //   if (distanation1 == locationData) {
  //     Navigator.of(context).pushNamed(Routes.checkOutConfirmRoute);
  //   }
  // }

  // Future Time () async{
  //   final directions = await GoogleMapDirections(apiKey: 'YOUR_API_KEY').directionsWithLocation(
  //     origin: Location(startLat, startLng),
  //     destination: Location(endLat, endLng),
  //   );
  //
  //   final distance = directions.distance;
  //   final duration = directions.duration;
  // }

  @override
  Widget build(BuildContext context) {
    var orderById1 = Provider
        .of<ProductProvider>(context)
        .orderById;
    var order = Provider
        .of<ProductProvider>(context)
        .unpaidOrder;
    // getColorBackground(orderById['statusName']);
    // getColorIcon(orderById['statusName']);
    // getTextSetuaition(orderById['statusName']);
    print('===================================statusName');
    print(orderById1['statusName']);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16),
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
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        AppLocalizations.of(context)!.track_order,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Divider(height: 2, color: ColorManager.greyLight),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
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
                      padding: EdgeInsets.all(10),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: orderById1['deliveryPoint'] == null
                          // ? LatLng(24.242978478140152,
                          // 54.710762053728104)
                              ? LatLng(locationData!.latitude!,
                              locationData!.longitude!)
                              : LatLng(
                              double.parse(
                                  orderById1['deliveryPoint']
                                  ['altitude']),
                              double.parse(
                                  orderById1['deliveryPoint']
                                  ['longitude'])),
                          zoom: 12.5,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId("source"),
                            position: orderById1['deliveryPoint'] ==
                                null
                                ? LatLng(locationData!.latitude!,
                                locationData!.longitude!)
                                : LatLng(
                                double.parse(
                                    orderById1['deliveryPoint']
                                    ['altitude']),
                                double.parse(
                                    orderById1['deliveryPoint']
                                    ['longitude'])),

                            // LatLng(
                            //     widget.orderinfo['deliveryPoint'],
                            //     widget.orderinfo['deliveryPoint']) ??
                          ),
                          Marker(
                            markerId: MarkerId("destination"),
                            position: orderById1['branch'] == null
                                ? LatLng(locationData!.latitude!,
                                locationData!.longitude!)
                                : LatLng(
                                double.parse(orderById1['branch']
                                ['branchAddress']
                                ['altitude']),
                                double.parse(orderById1['branch']
                                ['branchAddress']
                                ['longitude'])),
                          ),
                        },
                        onMapCreated: (mapController) {
                          _controller.complete(mapController);
                        },
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: polylineCoordinates,
                            color: const Color(0xFF7B61FF),
                            width: 5,
                          ),
                        },
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.time_Of_Your_Order_Arrival,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Provider
                        .of<ProductProvider>(context, listen: false)
                        .duration ??
                        AppLocalizations.of(context)!.calculate_time,
                    style: TextStyle(
                        fontSize: 18.0, color: ColorManager.primary),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.4,
                    // width: MediaQuery.of(context).size.height * 1,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: color1,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child: Icon(Icons.done, color: cIcon1, size: 35),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: color2,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child: Icon(Icons.local_print_shop_rounded,
                              color: cIcon2, size: 35),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: color3,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child: Icon(Icons.drive_eta_rounded,
                              color: cIcon3, size: 35),
                        ),
                        Spacer(),

                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: color4,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child:
                          Icon(Icons.done_all, color: cIcon4, size: 35),
                        ),

                        // widget.orderinfo['statusName'] == 'Intialized'
                        //     ? Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.done,
                        //             color: Colors.white, size: 35),
                        //       )
                        //     : Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.white,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.done,
                        //             color: Colors.grey, size: 35),
                        //       ),
                        // Container(
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12.r),
                        //     color: Colors.green,
                        //     border: Border.all(
                        //       color: Color(0xff125051),
                        //     ),
                        //   ),
                        //   child: Icon(Icons.done_all,
                        //       color: Colors.white, size: 35),
                        // ),
                        // widget.orderinfo['statusName'] == 'AssignedToEmployee'
                        //     ? Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.local_print_shop_rounded,
                        //             color: Colors.white, size: 35),
                        //       )
                        //     : Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.local_print_shop_rounded,
                        //             color: Colors.white, size: 35),
                        //       ),
                        // widget.orderinfo['statusName'] == 'ReadyForDriver'
                        //     ? Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.drive_eta_rounded,
                        //             color: Colors.white, size: 35),
                        //       )
                        //     : Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.drive_eta_rounded,
                        //             color: Colors.white, size: 35),
                        //       ),
                        // widget.orderinfo['statusName'] == 'Done'
                        //     ? Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.done_all,
                        //             color: Colors.white, size: 35),
                        //       )
                        //     : Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.r),
                        //           color: Colors.green,
                        //           border: Border.all(
                        //             color: Color(0xff125051),
                        //           ),
                        //         ),
                        //         child: Icon(Icons.done_all,
                        //             color: Colors.white, size: 35),
                        //       ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    textSetuaition,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.order_Number,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        Text(
                          '# 0',
                          style: getSemiBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.order_summary,
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
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff125051),
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
                              '${orderById1['totalCostForItems']
                                  .toString()} ${AppLocalizations.of(context)!
                                  .aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        orderById1['canPayLaterValue'] == null
                            ? Container()
                            : Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.you_can_pay_later,
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${orderById1['canPayLaterValue']
                                    .toString()} ${AppLocalizations.of(context)!
                                    .aed}',
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      BorderRadius.circular(
                          AppRadius.r8),
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
                              orderById1['deliveryPoint']['addressName'] ?? 'done',
                              style: getSemiBoldStyle(
                                color: ColorManager
                                    .primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Visibility(
                              visible: false,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors
                                    .lightGreenAccent,
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: AppSize.s10,
                        ),
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
                            orderById1['deliveryPoint']['addressName'] ?? 'done',
                            style: getRegularStyle(
                              color: ColorManager.black,
                            ),
                          ),
                        ]),
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
                            orderById1['deliveryPoint']['phone'],
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
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    child: ElevatedButton(onPressed: () {}, child: Column(
                      children: [
                        Icon(Icons.phone),
                        Text(AppLocalizations.of(context)!.call_Store,
                          style: TextStyle(fontSize: 10),)
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async{

                            // canLaunchUrl('tel://+1234567890'),
                            await call(Telephone: '+971559075523' );
                          }, child: Container(
                        width: 60,
                        height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              IconsAssets.call2,
                              color: Colors.white,
                              height: AppSize.s22,
                              width: AppSize.s22,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Call Shop',style: TextStyle(fontSize: AppSize.s12,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )),
                      SizedBox(width: 15,),
                      ElevatedButton(
                        onPressed: () async {
                          await whatsapp(phone: '+971559075523');
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                IconsAssets.whats_up,
                                color: Colors.white,
                                height: AppSize.s22,
                                width: AppSize.s22,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Whatsapp',style: TextStyle(fontSize: AppSize.s12,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  orderById1['statusName'] == 'Done'
                      ? Container(
                    child: ElevatedButton(
                        onPressed: () {
                          _customDialogFeedBack(context, orderById1);
                          // Navigator.of(context).pushReplacementNamed(
                          //     Routes.reviewProduct,
                          //     arguments: widget.orderId);
                        },
                        child: Text(AppLocalizations.of(context)!.feed_back)),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _customDialogFeedBack(context, Map<String, dynamic> orderById1) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s280,
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
                      padding: const EdgeInsets.all(10.0),
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
                            Navigator.pushNamed(context, Routes.rateSeller);
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
                            Navigator.pushNamed(context, Routes.rateDelivery);
                          },
                          child: orderById1['driverId'] == null
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
                              AppLocalizations.of(context)!.with_driver,
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

  whatsapp({required String phone})async {
    final url = "whatsapp://send?phone=$phone";

    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }else {
      throw 'Could not launch $url';
    }
  }

  call({required String Telephone})async {
    final url = "tel://$Telephone";

    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }else {
      throw 'Could not launch $url';
    }
  }
}
