import 'package:flutter/material.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharaYourOpinionView extends StatefulWidget {
  const SharaYourOpinionView({Key? key}) : super(key: key);

  @override
  State<SharaYourOpinionView> createState() => _SharaYourOpinionViewState();
}

class _SharaYourOpinionViewState extends State<SharaYourOpinionView> {
  late TextEditingController _notesTextController;
  @override
  void initState() {
    super.initState();
    _notesTextController = TextEditingController();
  }
  @override
  void dispose() {
    _notesTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.share_your_opinion,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Divider(height: 1, color: ColorManager.greyLight),
              SizedBox(
                height: AppSize.s14,
              ),
              Image.asset(
                ImageAssets.rate,
                height: AppSize.s192,
                width: AppSize.s306,
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Text(
                AppLocalizations.of(context)!.how_do_you_see_us,
                style: getMediumStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconsAssets.start,
                    height: AppSize.s33,
                    width: AppSize.s35,
                  ),
                  SizedBox(width: AppSize.s18,),
                  Image.asset(
                    IconsAssets.start,
                    height: AppSize.s33,
                    width: AppSize.s35,
                  ),
                  SizedBox(width: AppSize.s18,),
                  Image.asset(
                    IconsAssets.start,
                    height: AppSize.s33,
                    width: AppSize.s35,
                  ),
                  SizedBox(width: AppSize.s18,),
                  Image.asset(
                    IconsAssets.start,
                    height: AppSize.s33,
                    width: AppSize.s35,
                  ),
                  SizedBox(width: AppSize.s18,),
                  Image.asset(
                    IconsAssets.start,
                    height: AppSize.s33,
                    width: AppSize.s35,
                  ),
                  SizedBox(width: AppSize.s18,),
                ],
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  AppLocalizations.of(context)!.do_you_have_notes_to_tell_us,
                  style: getRegularStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              AppTextField(textController: _notesTextController, hint: '',lines: Constants.orderDetailsLines,),
              SizedBox(
                height: AppSize.s18,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () =>Navigator.pushReplacementNamed(context, Routes.registerRoute),
                  child: Text(
                    AppLocalizations.of(context)!.send_note,
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
