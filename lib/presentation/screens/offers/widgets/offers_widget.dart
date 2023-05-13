import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';

import '../../../resources/values_manager.dart';
import '../../product_view/product_view_new.dart';

class OffersWidget extends StatelessWidget {
  final String discountDescription;
  final String branchName;
  final String idProduct;
  final String productImages;

  OffersWidget(
      {required this.branchName,
      required this.productImages,
      required this.idProduct,
      required this.discountDescription});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductViewNew(
            idProduct: idProduct,
          ),
        ));
      },
      child: Container(
        padding: EdgeInsets.all(AppSize.s14),
        child: Row(
          children: [
            productImages == ''
                ? Image.asset(
                    ImageAssets.coffeeHouse,
                    height: AppSize.s75,
                  )
                : Container(
                    height: AppSize.s75,
                    width: AppSize.s75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                        image: DecorationImage(
                            image: NetworkImage(productImages),
                            fit: BoxFit.fill)),
                    // padding: EdgeInsets.all(AppSize.s12),
                  ),
            SizedBox(width: AppSize.s15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: Text(
                    discountDescription,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // Text(
                //   'valid from 19 january, 2023',
                //   style: TextStyle(
                //       color: ColorManager.greyLight,
                //       fontWeight: FontWeight.w500),
                // ),
                Text(
                  branchName,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Price on selection',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
