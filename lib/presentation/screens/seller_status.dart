import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

class SellerStatus extends StatefulWidget {

  final String message;
  SellerStatus(this.message);


  @override
  State<SellerStatus> createState() => _SellerStatusState();
}

class _SellerStatusState extends State<SellerStatus> {

  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var sellerStatus = Provider.of<SellerProvider>(context,listen: false).repo;
    print('============================sellerStatus2');
    print(sellerStatus);
    if(sellerStatus != null) {
      setState(() {
        isLoading = false;
      });
    }
    return Scaffold(
      body: Center(
        child: isLoading ? Center(
          child: Container(
            width: 20.h,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        ) : Text(widget.message),
      ),
    );
  }
}