// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialogWidget extends StatelessWidget {
  final String? title;

  const LoadingDialogWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                SpinKitDualRing(
                  color: Theme.of(context).primaryColor,
                  size: 25.r,
                  lineWidth: 2,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  title ?? 'Please Wait',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '...',
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      speed: const Duration(milliseconds: 150),
                      cursor: '',
                    ),
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
