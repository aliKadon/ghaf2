import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../../domain/model/adds.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class SliderImage extends StatefulWidget {
  final String imagesUrl;
  final String header;
  final String addDescription;
  final String addFooter;
  final List<Adds> listAdds;

  SliderImage({
    required this.imagesUrl,
    required this.header,
    required this.addDescription,
    required this.addFooter,
    required this.listAdds,
  });

  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  var isArabic = SharedPrefController().lang1;

  var isLoop = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.listAdds.length == 1) {
      isLoop = false;
    }else if (widget.listAdds.length > 1) {
      isLoop = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        height: MediaQuery.of(context).size.height * 0.3,
        // width: double.infinity,
        indicatorRadius: 4,
        isLoop: isLoop,
        autoPlayInterval: 4000,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                isArabic == 'en'
                    ? Image.asset(ImageAssets.blueRectangle)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.asset(
                          ImageAssets.blueRectangle,
                        ),
                      ),
                widget.imagesUrl == null || widget.imagesUrl == ''
                    ? Positioned(
                        top: AppSize.s20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            ImageAssets.brIcon,
                            height: AppSize.s46,
                            width: AppSize.s46,
                          ),
                        ))
                    : Positioned(
                        top: AppSize.s20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.network(
                            widget.imagesUrl,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              ImageAssets.brIcon,
                              height: AppSize.s46,
                              width: AppSize.s46,
                            ),
                            height: 40,
                            width: 40,
                          ),
                        )),
                Positioned(
                    top: AppSize.s73,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${widget.header}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.s16),
                      ),
                    )),
                Positioned(
                    top: AppSize.s110,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${widget.addDescription}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.s16),
                      ),
                    )),
                widget.addFooter != "Footer"
                    ? Positioned(
                        top: 140,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${widget.addFooter}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s16),
                          ),
                        ))
                    : Container(),
              ],
            ),
          ),
        ]);

    // ImageSlideshow(
    //   height: MediaQuery.of(context).size.height * 0.5,
    //   indicatorRadius: 4,
    //   isLoop: true,
    //   autoPlayInterval: 4000,
    //   children: List<Widget>.generate(
    //     1,
    //         (index) {
    //       return GestureDetector(
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(15),
    //           child: Image.asset(
    //             ImageAssets.productImage,
    //             fit: BoxFit.cover,
    //             height: MediaQuery.of(context).size.height * 0.5,
    //             width: MediaQuery.of(context).size.width * 1,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
