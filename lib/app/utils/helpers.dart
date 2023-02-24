import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/widgets/dialogs/loading_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/styles_manager.dart';


mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  // show loading dialog.
  void showLoadingDialog({
    required BuildContext context,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (_) => LoadingDialogWidget(
        title: title,
      ),
      barrierDismissible: false,
    );
  }

  // format date.
  static String formatDate(DateTime dateTime, {bool withTime = false}) {
    if (withTime) {
      return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  Future showSheet(BuildContext context) => showSlidingBottomSheet(
    context,
    builder: (context) => SlidingSheetDialog(
      snapSpec: SnapSpec(
        snappings: [0.4, 0.7],
      ),
      builder: (context, state) => Material(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
                Text(AppLocalizations.of(context)!.canceling_order,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primaryDark)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
                Text(AppLocalizations.of(context)!.are_you_sure_cancel,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.primary)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => LoginScreen(),
                          // ));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorManager.primaryDark),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        child: Text(
                          AppLocalizations.of(context)!.yes,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.white, fontSize: 18),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => RegisterScreen(),
                          // ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: ColorManager.primaryDark),
                                    borderRadius: BorderRadius.circular(10)))),
                        child: Text(
                          AppLocalizations.of(context)!.no,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.primaryDark, fontSize: 18),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),


                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
