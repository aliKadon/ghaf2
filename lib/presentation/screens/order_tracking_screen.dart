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
    if (statusName == 'Intialized' || statusName == 'NotAssignedToEmployee' ||
        statusName == 'UnPaid' || statusName == 'Paid') {
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
    } else
    if (statusName == 'ReadyForDriver' || statusName == 'AssignedToDriver' ||
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
    if (statusName == 'Intialized' || statusName == 'NotAssignedToEmployee' ||
        statusName == 'UnPaid' || statusName == 'Paid') {
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
    } else
    if (statusName == 'ReadyForDriver' || statusName == 'AssignedToDriver' ||
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
    if (statusName == 'Intialized' || statusName == 'NotAssignedToEmployee' ||
        statusName == 'UnPaid' || statusName == 'Paid') {
      setState(() {
        textSetuaition = 'Great, You have an Order now! ';
      });
    } else if (statusName == 'AssignedToEmployee' ||
        statusName == 'NotAssignedToDriver') {
      setState(() {
        textSetuaition = ' staff are processing the order! ';
      });
    } else
    if (statusName == 'ReadyForDriver' || statusName == 'AssignedToDriver' ||
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
    Provider.of<ProductProvider>(context, listen: false)
        .getOrderById(widget.orderId)
        .then((value) => getLocation())
        .then((value) =>
        getPolyPoints(double.parse(Provider
            .of<ProductProvider>(context, listen: false)
            .orderById['deliveryPoint']['altitude']),
            double.parse(Provider
                .of<ProductProvider>(context, listen: false)
                .orderById['deliveryPoint']['longitude'] ?? locationData!.longitude!), double.parse(Provider
                .of<ProductProvider>(context, listen: false)
                .orderById['branch']['branchAddress']['altitude']), double.parse(Provider
                .of<ProductProvider>(context, listen: false)
                .orderById['branch']['branchAddress']['altitude'])))
        .then((value) =>
        Provider.of<ProductProvider>(context, listen: false)
            .getDurationGoogleMap(
          LatOne: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['deliveryPoint']['altitude'] ??
                  locationData!.latitude),
          LonOne: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['deliveryPoint']['longitude'] ??
                  locationData!.longitude),
          LatTow: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['branch']['branchAddress']['altitude'] ??
                  locationData!.latitude),
          LonTow: double.parse(
              Provider
                  .of<ProductProvider>(context, listen: false)
                  .orderById['branch']['branchAddress']['longitude'] ??
                  locationData!.longitude),
        ))
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
        getTextSetuaition(Provider
            .of<ProductProvider>(context, listen: false)
            .orderById['statusName']))
        .then((value) => isLoading = false);

    // Provider.of<ProductProvider>(context, listen: false).getDurationGoogleMap(
    //   LatOne: 37.33500926,
    //   LonOne: -122.03272188,
    //   LatTow: 37.33429383,
    //   LonTow: -122.06600055,
    // );
    super.initState();
  }

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

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints(double sourceLat, double sourceLong, double destLat,
      double destLong) async {
    Timer(Duration(seconds: 5), () async {
      print('=========================location');
      print(locationData?.longitude);
      print(widget.orderId);
      // setState(() {
      //
      // });
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.google_key_map, // Your Google Map Key
        // PointLatLng(
        //     widget.orderinfo['deliveryPoint']['latitude'] ??
        //         locationData!.latitude!,
        //     widget.orderinfo['deliveryPoint']['longitude'] ??
        //         locationData!.longitude!),
        // PointLatLng(
        //     widget.orderinfo['branchAddress']['latitude'] ??
        //         destination1.latitude,
        //     widget.orderinfo['branchAddress']['longitude'] ??
        //         destination1.longitude),
        PointLatLng(sourceLat,
            sourceLong),
        PointLatLng(
            destLat, destLong),
        // PointLatLng(locationData!.latitude!, locationData!.latitude!),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach(
              (PointLatLng point) =>
              polylineCoordinates.add(
                LatLng(point.latitude, point.longitude),
              ),
        );

        // if(!mounted) return;
        // setState(() {
        //   // isLoading = false;
        // });
      }
    });
  }

  void getOrderLocationToreview(LocationData currentLocation,
      LocationData distanation1) {
    if (distanation1 == locationData) {
      Navigator.of(context).pushNamed(Routes.checkOutConfirmRoute);
    }
  }

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
    var orderById = Provider
        .of<ProductProvider>(context)
        .orderById;
    // getColorBackground(orderById['statusName']);
    // getColorIcon(orderById['statusName']);
    // getTextSetuaition(orderById['statusName']);
    print('===================================statusName');
    print(orderById['statusName']);
    return Scaffold(
      body: SafeArea(
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
                      'Tracking Your Order',
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
                        target: orderById['deliveryPoint'] == null
                            ? LatLng(locationData!.latitude!,
                            locationData!.longitude!)
                            : LatLng(
                            double.parse(
                                orderById['deliveryPoint']
                                ['altitude']),
                            double.parse(
                                orderById['deliveryPoint']
                                ['longitude'])),
                        zoom: 12.5,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId("source"),
                          position:
                          orderById['deliveryPoint'] == null
                              ? LatLng(locationData!.latitude!,
                              locationData!.longitude!)
                              : LatLng(
                              double.parse(
                                  orderById['deliveryPoint']
                                  ['altitude']),
                              double.parse(
                                  orderById['deliveryPoint']
                                  ['longitude'])),

                          // LatLng(
                          //     widget.orderinfo['deliveryPoint'],
                          //     widget.orderinfo['deliveryPoint']) ??
                        ),
                        Marker(
                          markerId: MarkerId("destination"),
                          position:
                          orderById['branchAddress'] == null
                              ? destination1
                              : LatLng(
                              double.parse(
                                  orderById['branchAddress']
                                  ['altitude']),
                              double.parse(
                                  orderById['branchAddress']
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
                          width: 6,
                        ),
                      },
                    ),
                  ),
                ),
                Text(
                  "Time Of Your Order Arrival",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${Provider
                      .of<ProductProvider>(context, listen: false)
                      .duration}' ??
                      '0',
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
                  height: 30,
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            Routes.reviewProduct,
                            arguments: widget.orderId);
                      },
                      child: Text('Give Feedback for product')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
