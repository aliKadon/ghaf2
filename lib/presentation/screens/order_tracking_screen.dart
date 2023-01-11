import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class OrderTrackingScreen extends StatefulWidget {
  final Map<String, dynamic> orderinfo;

  OrderTrackingScreen(this.orderinfo);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();

}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  Color color1 = Colors.green;
  Color color2 = Colors.green;
  Color color3 = Colors.green;
  Color color4 = Colors.green;

  Color cIcon1 = Colors.green;
  Color cIcon2 = Colors.green;
  Color cIcon3 = Colors.green;
  Color cIcon4 = Colors.green;

  var textSetuaition = '';

  void getColorBackground(String statusName) {
    if (statusName == 'Intialized') {
      setState(() {
        color1 = Colors.green;
        color2 = Colors.white;
        color3 = Colors.white;
        color4 = Colors.white;
      });
    } else if (statusName == 'AssignedToEmployee') {
      setState(() {
        color2 = Colors.green;
        color1 = Colors.white;
        color3 = Colors.white;
        color4 = Colors.white;
      });
    } else if (statusName == 'ReadyForDriver') {
      setState(() {
        color3 = Colors.green;
        color1 = Colors.white;
        color2 = Colors.white;
        color4 = Colors.white;
      });
    } else if (statusName == 'Done') {
      setState(() {
        color4 = Colors.green;
        color1 = Colors.white;
        color2 = Colors.white;
        color3 = Colors.white;
      });
    }
  }

  void getColorIcon(String statusName) {
    if (statusName == 'Intialized') {
      setState(() {
        cIcon1 = Colors.white;
        cIcon2 = Colors.green;
        cIcon3 = Colors.green;
        cIcon4 = Colors.green;
      });
    } else if (statusName == 'AssignedToEmployee') {
      setState(() {
        cIcon2 = Colors.white;
        cIcon1 = Colors.green;
        cIcon3 = Colors.green;
        cIcon4 = Colors.green;
      });
    } else if (statusName == 'ReadyForDriver') {
      setState(() {
        cIcon3 = Colors.white;
        cIcon1 = Colors.green;
        cIcon2 = Colors.green;
        cIcon4 = Colors.green;
      });
    } else if (statusName == 'Done') {
      setState(() {
        cIcon4 = Colors.white;
        cIcon1 = Colors.green;
        cIcon2 = Colors.green;
        cIcon3 = Colors.green;
      });
    }
  }

  void getTextSetuaition(String statusName) {
    if (statusName == 'Intialized') {
      setState(() {
        textSetuaition = 'Great, You have an Order now! ';
      });
    } else if (statusName == 'AssignedToEmployee') {
      setState(() {
        textSetuaition = ' staff are processing the order! ';
      });
    } else if (statusName == 'ReadyForDriver') {
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
    getLocation();
    getPolyPoints();
    super.initState();
  }

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
    print(widget.orderinfo);
  }

  // LocationData locationData = await location.getLocation();

  final Completer<GoogleMapController> _controller = Completer();

  // late LatLng destination;
  static LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static LatLng destination1 = LatLng(37.33429383, -122.06600055);

  // destination = LatLng(locationData!.latitude!, locationData!.latitude!);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    Timer(Duration(seconds: 7), () async {
      print('=========================location');
      print(locationData?.longitude);
      print(widget.orderinfo['statusName']);
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
        PointLatLng(
                locationData!.latitude!,
                locationData!.longitude!),
        PointLatLng(
                destination1.latitude,
                destination1.longitude),
        // PointLatLng(locationData!.latitude!, locationData!.latitude!),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach(
          (PointLatLng point) => polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          ),
        );

        if(!mounted) return;
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void getOrderLocationToreview(
      LocationData currentLocation, LocationData distanation1) {
    if (distanation1 == locationData) {
      Navigator.of(context).pushNamed(Routes.checkOutConfirmRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    getColorBackground(widget.orderinfo['statusName']);
    getColorIcon(widget.orderinfo['statusName']);
    getTextSetuaition(widget.orderinfo['statusName']);
    return Scaffold(
      body: SafeArea(
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
                SizedBox(
                  height: 10,
                ),
                Divider(height: 1, color: ColorManager.greyLight),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
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
                          padding: EdgeInsets.all(10),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: widget.orderinfo['deliveryPoint'] == null
                                  ? LatLng(locationData!.latitude!,
                                      locationData!.longitude!)
                                  : LatLng(
                                      widget.orderinfo['deliveryPoint']
                                          ['latitude'],
                                      widget.orderinfo['deliveryPoint']
                                          ['longitude']),
                              zoom: 12.5,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId("source"),
                                position: LatLng(locationData!.latitude!,
                                    locationData!.longitude!),

                                // LatLng(
                                //     widget.orderinfo['deliveryPoint'],
                                //     widget.orderinfo['deliveryPoint']) ??
                              ),
                              Marker(
                                markerId: MarkerId("destination"),
                                position:
                                    widget.orderinfo['branchAddress'] == null
                                        ? destination1
                                        : LatLng(
                                            widget.orderinfo['branchAddress']
                                                ['latitude'],
                                            widget.orderinfo['branchAddress']
                                                ['longitude']),
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
                        child: Icon(Icons.done_all, color: cIcon4, size: 35),
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
                        Navigator.of(context).pushReplacementNamed(Routes.reviewProduct,
                            arguments: widget.orderinfo);
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
