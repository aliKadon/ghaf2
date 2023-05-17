import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../../domain/model/adds.dart';
import '../../domain/model/store_adds.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class SliderImageSave extends StatefulWidget {
  final String imagesUrl;
  final String header;
  final String addDescription;
  final String addFooter;
  final List<StoreAdds> listAdds;

  SliderImageSave({
    required this.imagesUrl,
    required this.header,
    required this.addDescription,
    required this.addFooter,
    required this.listAdds,
  });

  @override
  State<SliderImageSave> createState() => _SliderImageSaveState();
}

class _SliderImageSaveState extends State<SliderImageSave> {
  var isArabic = SharedPrefController().lang1;

  var isLoop = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.listAdds.length == 1) {
      isLoop = false;
    } else if (widget.listAdds.length > 1) {
      isLoop = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        height: MediaQuery.of(context).size.height * 0.15,
        // width: double.infinity,
        indicatorRadius: 4,
        isLoop: isLoop,
        autoPlayInterval: 4000,
        children: [
          Card(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.s9),
                  child: isArabic == 'en'
                      ? Image.network(
                          widget.imagesUrl,
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImageAssets.save,
                              height: MediaQuery.of(context).size.width * 0.2,
                              width: MediaQuery.of(context).size.width * 0.2,
                            );
                          },
                        )
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Image.network(
                            widget.imagesUrl,
                            height: MediaQuery.of(context).size.width * 0.14,
                            width: MediaQuery.of(context).size.width * 0.2,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImageAssets.save,
                                height: MediaQuery.of(context).size.width * 0.14,
                                width: MediaQuery.of(context).size.width * 0.2,
                              );
                            },
                          )
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.header} ${AppLocalizations.of(context)!.aed} ${widget.listAdds.isEmpty ? 0 : widget.listAdds[0].saveValue}',
                      style: TextStyle(
                          fontSize: FontSize.s16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      '${widget.listAdds[0].addDescription}',
                      style: TextStyle(
                          fontSize: FontSize.s12, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
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
    //           borderRadius: BorderRadius.circular(AppSize.s15),
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
