import 'package:flutter/material.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class NotificationsWidget extends StatelessWidget {
  String text;
  String storeName;
  String? imageUrl;

  NotificationsWidget({required this.text,required this.storeName,required this.imageUrl});

  var language = SharedPrefController().lang1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.s14),
      child: Column(
        children: [
          language == 'en'
              ? imageUrl == null ? Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(45),
                          bottomLeft: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.notificationImage,),
                          fit: BoxFit.cover)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(42),
                        bottomLeft: Radius.circular(5)),
                    child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: ColorManager.grey,
                          leading: Text(
                            'big Saving with ${storeName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        child: Container()),
                  ),
                ) : Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(45),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(42),
                  bottomLeft: Radius.circular(5)),
              child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: ColorManager.grey,
                    leading: Text(
                      'big Saving with ${storeName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s14),
                    ),
                  ),
                  child: Container()),
            ),
          )
              : imageUrl == null ? Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.notificationImage),
                          fit: BoxFit.cover)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(42),
                        bottomRight: Radius.circular(5)),
                    child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: ColorManager.grey,
                          leading: Text(
                            'big Saving with ${storeName} ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        child: Container()),
                  ),
                ) : Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(5)),
              child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: ColorManager.grey,
                    leading: Text(
                      'big Saving with ${storeName} ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s14),
                    ),
                  ),
                  child: Container()),
            ),
          ),
          SizedBox(
            height: AppSize.s30,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
