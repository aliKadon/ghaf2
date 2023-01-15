import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:ghaf_application/app/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddPaymentCardSellerView extends StatefulWidget {
  // const AddPaymentCardSellerView({Key? key}) : super(key: key);
  final String planeId;

  AddPaymentCardSellerView(this.planeId);

  @override
  State<AddPaymentCardSellerView> createState() =>
      _AddPaymentCardSellerViewState();
}

class _AddPaymentCardSellerViewState extends State<AddPaymentCardSellerView>
    with Helpers {
  var monthly = false;
  var annual = false;
  var option = '';
  var subscribeResponse;

  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;

  @override
  void initState() {
    Provider.of<SellerProvider>(context,listen: false).getUserDetails();
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var repo = Provider.of<SellerProvider>(context).repo;
    var userInfo = Provider.of<SellerProvider>(context).userDetails;
    print('============================repo');
    print(repo);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s9,
              ),
              Text(
                AppLocalizations.of(context)!.add_payment_card,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s24),
              ),
              SizedBox(
                height: AppSize.s9,
              ),
              Image.asset(
                ImageAssets.logo2,
                height: AppSize.s192,
                width: AppSize.s192,
              ),
              SizedBox(
                height: AppSize.s9,
              ),
              Text(
                AppLocalizations.of(context)!
                    .to_complete_the_store_registration,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s20),
              ),
              SizedBox(
                height: AppSize.s30,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.number_card,
              ),
              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.cvv,
                textInputType: TextInputType.emailAddress,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      textController: _passwordTextController,
                      hint: AppLocalizations.of(context)!.expired_month,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      textController: _phoneTextController,
                      hint: AppLocalizations.of(context)!.expired_year,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Radio(
              //             value: '538ca56d-059d-4aa1-9e76-08daecd00fd8',
              //             onChanged: (n) {
              //               setState(() {
              //                 monthly = !monthly;
              //                 option = n!;
              //                 print('==============================option');
              //                 print(option);
              //               });
              //             },
              //             groupValue: option),
              //         Text(
              //           'Monthly',
              //           style: getRegularStyle(
              //               color: ColorManager.grey, fontSize: FontSize.s16),
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       height: AppSize.s82,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Radio(
              //             value: 'b744fc7b-1d84-4dfb-9e77-08daecd00fd8',
              //             onChanged: (n) {
              //               setState(() {
              //                 print('==============================option');
              //
              //                 annual = !annual;
              //                 option = n!;
              //                 print(n);
              //               });
              //             },
              //             groupValue: option),
              //         Text(
              //           'Annual',
              //           style: getRegularStyle(
              //               color: ColorManager.grey, fontSize: FontSize.s16),
              //         ),
              //         SizedBox(
              //           height: AppSize.s82,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              SizedBox(
                height: AppSize.s9,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(
              //     horizontal: AppMargin.m16,
              //   ),
              //   width: double.infinity,
              //   height: AppSize.s55,
              //   child:
              // ),
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(

                      onPressed: (){

                        _customDialogCancel(context);
                      }, child: Text(AppLocalizations.of(context)!.cancel)),
                  SizedBox(width: 5,),
                  userInfo['role'] == 'Seller' ? ElevatedButton(
                    onPressed: () {
                      _checkData();
                      if (_checkData()) {
                        Provider.of<SellerProvider>(context, listen: false)
                            .addPaymentCardSeller(
                            context,
                            _nameTextController.text,
                            _emailTextController.text,
                            int.parse(_passwordTextController.text),
                            int.parse(_phoneTextController.text),
                            widget.planeId)
                        //     .then((value) => ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(
                        //   content: Text(repo,style: TextStyle(color: Colors.white)),
                        //   backgroundColor: Colors.green,
                        // )))
                            .then((value) =>   Navigator.pushReplacementNamed(
                            context, Routes.loginRoute))
                            .catchError((e) => ScaffoldMessenger.of(context)
                            .showSnackBar(
                            SnackBar(content: Text(repo,style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,)));
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.create_store,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ) : ElevatedButton(
                    onPressed: () {
                      _checkData();
                      if (_checkData()) {
                        Provider.of<SellerProvider>(context, listen: false)
                            .addPaymentCard(
                            context,
                            _nameTextController.text,
                            _emailTextController.text,
                            int.parse(_passwordTextController.text),
                            int.parse(_phoneTextController.text),
                            widget.planeId)
                        //     .then((value) => ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(
                        //   content: Text(repo,style: TextStyle(color: Colors.white)),
                        //   backgroundColor: Colors.green,
                        // )))
                            .then((value) =>   Navigator.pushReplacementNamed(
                            context, Routes.registerPaymentLinkSellerRoute))
                            .catchError((e) => ScaffoldMessenger.of(context)
                            .showSnackBar(
                            SnackBar(content: Text(repo,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red,)));
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.create_store,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s16,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      return _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: AppLocalizations.of(context)!.enter_required_data, error: true);
    return false;
  }

  Future<void> _register() async {}

  void _customDialogCancel(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s280,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Subscription Seller',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text('We deliver grocery at your door step',style: TextStyle(fontSize: AppSize.s18),),
                    // ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Text('Are you sure to cancel the payment?',style: TextStyle(fontSize: AppSize.s20),),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s28,
                    ),

                    // SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Routes.loginRoute);
                          },

                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius:
                              BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              textAlign: TextAlign.center,
                              style:
                              getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSize.s10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius:
                              BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              textAlign: TextAlign.center,
                              style:
                              getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        });
  }
  // void _customDialogProgress() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: Container(
  //             height: AppSize.s214,
  //             width: AppSize.s258,
  //             decoration: BoxDecoration(
  //               color: ColorManager.white,
  //               borderRadius: BorderRadius.circular(AppRadius.r8),
  //             ),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     height: AppSize.s28,
  //                   ),
  //                   Text(
  //                     AppLocalizations.of(context)!.progress,
  //                     style: getMediumStyle(
  //                         color: ColorManager.primaryDark,
  //                         fontSize: FontSize.s20),
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s40,
  //                   ),
  //                   Text(
  //                     AppLocalizations.of(context)!
  //                         .your_account_is_under_approval_process,
  //                     style: getMediumStyle(
  //                         color: ColorManager.primary, fontSize: FontSize.s12),
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s40,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () =>
  //                         Navigator.of(context).pushNamed(Routes.loginRoute),
  //                     child: Container(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: AppPadding.p55,
  //                         vertical: AppPadding.p8,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: ColorManager.primaryDark,
  //                         borderRadius: BorderRadius.circular(AppRadius.r8),
  //                       ),
  //                       child: Text(
  //                         AppLocalizations.of(context)!.close,
  //                         style: getMediumStyle(color: ColorManager.white),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s12,
  //                   ),
  //                 ]),
  //           ),
  //         );
  //       });
  // }
}
