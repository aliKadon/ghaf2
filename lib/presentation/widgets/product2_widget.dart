import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/constants.dart';
import '../../domain/model/product2.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class ProductWidget2 extends StatefulWidget {
  final Product2 product;
  final String tag;

  ProductWidget2(this.product, this.tag);

  @override
  State<ProductWidget2> createState() => _ProductWidget2State();
}

class _ProductWidget2State extends State<ProductWidget2> {
  @override
  void initState() {
    super.initState();
  }

  // // controller.
  // late final Product _product = Get.find<Product>(
  //   tag: widget.tag,
  // );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productView2,
          arguments: widget.product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r14),
                child: Container(
                  height: AppSize.s211,
                  width: AppSize.s154,
                  color: Colors.white,
                  child: widget.product.ghafImage == null
                      ? Image.asset('assets/images/product_image.png',fit: BoxFit.cover,)
                      : Image.network(
                          widget.product.ghafImage![0]['data'],
                          height: AppSize.s211,
                          width: AppSize.s154,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) =>
                              Center(
                            child: Icon(
                              Icons.broken_image,
                            ),
                          ),
                        ),
                ),
              ),
              // if (widget.minProductCountForGift != null)
              PositionedDirectional(
                start: 0,
                end: 0,
                top: -55,
                child: Image.asset(
                  '${Constants.imagesPath}gift.png',
                ),
              ),
              // if (widget.minProductCountForGift != null)
              PositionedDirectional(
                start: 0,
                end: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(14.r)),
                  ),
                  // child: Center(
                  //   child: Text(
                  //     'Buy ${widget.minProductCountForGift} get ${widget.giftCount} free',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 14.sp,
                  //     ),
                  //   ),
                ),
              ),

              // PositionedDirectional(
              //   end: AppSize.s12,
              //   top: AppSize.s12,
              //   child: InkWell(
              //     onTap: () {
              //       widget.product.toggleIsFavorite(context: context);
              //     },
              //     child: GetBuilder<Product>(
              //       id: 'isFavorite',
              //       tag: widget.tag,
              //       builder: (controller) => CircleAvatar(
              //         radius: AppRadius.r14,
              //         backgroundColor: ColorManager.burgundy,
              //         child: Image.asset(
              //           controller.isFavorite!
              //               ? IconsAssets.heart1
              //               : IconsAssets.heart,
              //           height: AppSize.s16,
              //           width: AppSize.s16,
              //           color:
              //           controller.isFavorite! ? Colors.red : Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: AppPadding.p22),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              widget.product.name ?? '',
              style: getSemiBoldStyle(
                color: ColorManager.primaryDark,
                fontSize: FontSize.s14,
              ),
            ),
          ),
          // SizedBox(
          //   height: AppSize.s4,
          // ),
          Container(
            padding: EdgeInsetsDirectional.only(start: AppPadding.p22),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              widget.product.branch?['branchName'] ?? '',
              style: getRegularStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s10,
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s8,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: AppPadding.p22),
            child: Row(
              children: [
                if (widget.product.productDiscount != null) ...[
                  Text(
                    '\$ ${(widget.product.price! * (widget.product.productDiscount!['discount']! / 100)).toStringAsFixed(1)}',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                    ),
                  ),
                  SizedBox(width: AppSize.s10),
                ],
                Text(
                  '\$${widget.product.price!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: FontSize.s10,
                    fontFamily: FontConstants.fontFamily,
                    color: ColorManager.red,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                // Spacer(),
                // Image.asset(
                //   IconsAssets.start,
                //   height: AppSize.s14,
                //   width: AppSize.s15,
                // ),
                // SizedBox(
                //   width: AppSize.s8,
                // ),
                // Text(
                //   widget.product.productReview ?? '',
                //   style: getRegularStyle(
                //     color: ColorManager.black,
                //     fontSize: FontSize.s12,
                //   ),
                // ),
                // Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
