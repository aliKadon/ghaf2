import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/product2.dart';
import 'package:ghaf_application/presentation/resources/string_manager.dart';
import 'package:ghaf_application/presentation/screens/about_app_view.dart';
import 'package:ghaf_application/presentation/screens/account_view/account_view.dart';
import 'package:ghaf_application/presentation/screens/add_or_edit_address_view/add_or_edit_address_view.dart';
import 'package:ghaf_application/presentation/screens/add_or_edit_address_view/add_or_edit_address_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/all_restaurant_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_confirm_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/order_tracking_screen.dart';
import 'package:ghaf_application/presentation/screens/checkout/snapsheet_screen.dart';
import 'package:ghaf_application/presentation/screens/coupons_view.dart';
import 'package:ghaf_application/presentation/screens/faq_view.dart';
import 'package:ghaf_application/presentation/screens/forget_password_view/forget_password_view.dart';
import 'package:ghaf_application/presentation/screens/forget_password_view/forgot_password_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/gifts_view/gifts_view.dart';
import 'package:ghaf_application/presentation/screens/gifts_view/gifts_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view.dart';
import 'package:ghaf_application/presentation/screens/invite.dart';
import 'package:ghaf_application/presentation/screens/language.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/my_favorite_screen/my_favorite_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet_view.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_view.dart';
import 'package:ghaf_application/presentation/screens/order_information_view.dart';
import 'package:ghaf_application/presentation/screens/orders_history_view/orders_history_view.dart';
import 'package:ghaf_application/presentation/screens/orders_to_pay_view/order_to_pay_2.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_view.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view2.dart';
import 'package:ghaf_application/presentation/screens/products_screen/all_products_screen.dart';
import 'package:ghaf_application/presentation/screens/products_screen/products_screen.dart';
import 'package:ghaf_application/presentation/screens/profile/notification/notification_view.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_setting/profile_setting_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/rate_seller.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/share_opinion_view.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/reset_password_view/reset_password_view.dart';
import 'package:ghaf_application/presentation/screens/reset_password_view/reset_password_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/rewards/rewards_view_new.dart';
import 'package:ghaf_application/presentation/screens/seller/add_item_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/checkout_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/choose_payment_method_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/add_bank_account_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/add_item2_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/create_payment_link_without_details/create_payment_link_2_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/main_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/payment_link_subscription_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/products_with_out_details_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/register_payment_link_seller/register_payment_link_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/shop_address_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/store_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/add_payment_card_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/register_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/subscription_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/submit_form_view/submit_form_view.dart';
import 'package:ghaf_application/presentation/screens/seller/submit_form_view/submit_form_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/seller/update_info_seller.dart';
import 'package:ghaf_application/presentation/screens/seller/welcome_seller_view.dart';
import 'package:ghaf_application/presentation/screens/site_privacy_view.dart';
import 'package:ghaf_application/presentation/screens/store_by_category/store_by_category_screen.dart';
import 'package:ghaf_application/presentation/screens/sub_categories_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/payment_method_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_from_home_page.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/terms_use_view.dart';
import 'package:ghaf_application/presentation/screens/update_user_info.dart';

import '../../domain/model/unpaid_order.dart';
import '../screens/language_store.dart';
import '../screens/login_view/login_view.dart';
import '../screens/notifications/notifications_screen_new.dart';
import '../screens/onboarding_view.dart';
import '../screens/rate_and_reviews/rate_delivery/rate_delivery.dart';
import '../screens/rate_and_reviews/rate_us_view/rate_us_view.dart';
import '../screens/rate_and_reviews/rate_us_view/rate_us_view_getx_controller.dart';
import '../screens/rate_and_reviews/review_product.dart';
import '../screens/register_view/register_view.dart';
import '../screens/registration_screen.dart';
import '../screens/seller/individual_seller/create_payment_link_without_details/create_payment_link_seller_view.dart';
import '../screens/seller/regular_seller/seller_status.dart';
import '../screens/splash_view.dart';
import '../screens/subscribe_view/payment_methode_for_subscribe.dart';
import '../screens/unpaid_items_screen.dart';
import '../screens/verified_email.dart';
import '../screens/vouchers/vouchers.dart';
import '../screens/welcome_view.dart';

class Routes {
  //customer
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String welcomeRoute = "/welcome";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String resetPassword = "/resetPassword";
  static const String mainRoute = "/main";
  static const String subCategoriesRoute = "/subCategories";
  static const String productRoute = "/product";
  static const String checkOutRoute = "/checkOut";
  static const String checkOutConfirmRoute = "/checkOutConfirm";
  static const String orderInformationRoute = "/orderInformation";
  static const String allRestaurantRoute = "/allRestaurant";
  static const String aboutAppRoute = "/aboutApp";
  static const String addressesRoute = "/addresses";
  static const String rewardsRoute = "/rewards";
  static const String fAQRoute = "/fAQ";
  static const String sharaYourOpinionRoute = "/sharaYourOpinion";
  static const String notificationRoute = "/notification";
  static const String OrdersHistoryRoute = "/OrdersHistory";
  static const String sitePrivacyRoute = "/sitePrivacy";
  static const String termsOfUseRoute = "/termsOfUse";
  static const String offersRoute = "/offers";
  static const String vouchers = "/vouchers";
  static const String myWalletRoute = "/myWallet";
  static const String paymentMethodRoute = "/paymentMethod";
  static const String addOrEditAddressRoute = "/addOrEditAddress";
  static const String payLaterRoute = "/pay_later";
  static const String couponsRoute = "/coupons";
  static const String subscribeRoute = "/subscribe";
  static const String products = "/products";
  static const String myFavorite = "/myFavorite";
  static const String rateUs = "/rateUs";
  static const String ordersToPay = "/ordersToPay";
  static const String gifts = "/gifts";

  //new routs
  static const String orderTrackingScreen = "/orderTrackingScreen";
  static const String subscribeFromHomePage = "/subscribeFromHomePage";
  static const String homePage = "/homePage";
  static const String allProductScreen = "/allProductScreen";
  static const String updateUserInfo = "/updateUserInfo";
  static const String updateSellerInfo = "/updateSellerInfo";
  static const String accountView = "/accountView";
  static const String storeByCategoryScreen = "/storeByCategoryScreen";
  static const String notificationNew = "/notificationNew";

  //seller
  static const String welcomeSellerRoute = "/welcome_seller";
  static const String registerSellerRoute = "/register_seller";
  static const String subscriptionSellerRoute = "/subscription_seller";
  static const String checkoutSellerRoute = "/checkout_seller";
  static const String choosePaymentMethodRoute = "/choose_payment_method";
  static const String addPaymentCardSelleRoute = "/add_payment_card_selle";
  static const String paymentLinkSubscriptionSellerRoute =
      "/payment_link_subscription_seller";
  static const String registerPaymentLinkSellerRoute =
      "/register_payment_link_seller";
  static const String shopAddressSellerRoute = "/shop_address_seller";
  static const String addBankAccountSellerRoute = "/add_bank_account_seller";
  static const String productsWithOutDetailsSellerRoute =
      "/products_without_details_seller";
  static const String mainSellerRoute = "/main_seller";
  static const String createPaymentLinkSellerRoute =
      "/create_payment_link_seller";
  static const String createPaymentLink2SellerRoute =
      "/create_payment_link2_seller";
  static const String addItemSellerRoute = "/add_item_seller";
  static const String addItem2SellerRoute = "/add_item2_seller";
  static const String submitForm = "/submitForm";

  static const String snapsheet = '/snapsheet';
  static const String unpaidItemScreen = '/unpainItemScreen';
  static const String productView2 = '/productView2';
  static const String inviteScreen = '/invite';
  static const String paymentMethodeForSubscribe = '/paymentSubscribe';
  static const String reviewProduct = '/reviewProduct';
  static const String registeraition = '/registeraition';

  static const String storeSellerView = '/storeSellerView';
  static const String language = '/language';
  static const String languageStore = '/languageStore';
  static const String sellerStatus = '/sellerStatus';
  static const String verifiedEmail = '/verifiedEmail';
  static const String rateDelivery = '/rateDelivery';
  static const String rateSeller = '/rateSeller';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    switch (settings.name) {
      // switch ("/add_item2_seller") {
      //customer
      case Routes.snapsheet:
        return MaterialPageRoute(builder: (_) => SnapsheetScreen());

      case Routes.reviewProduct:
        return MaterialPageRoute(
            builder: (_) =>
                ReviewProduct(settings.arguments as Map<String, dynamic>));

      case Routes.rateDelivery:
        return MaterialPageRoute(
            builder: (_) => RateDelivery(
                  deliveryId: settings.arguments as String,
                ));

      case Routes.rateSeller:
        return MaterialPageRoute(builder: (_) => RateSeller());

      case Routes.notificationNew:
        return MaterialPageRoute(builder: (_) => NotificationsScreenNew());

      case Routes.vouchers:
        return MaterialPageRoute(builder: (_) => Vouchers());

      case Routes.verifiedEmail:
        return MaterialPageRoute(builder: (_) => VerifiedEmail());

      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.registeraition:
        return MaterialPageRoute(
            builder: (_) => RegistrationScreen(settings.arguments as String));

      case Routes.inviteScreen:
        return MaterialPageRoute(builder: (_) => Invite());
      case Routes.paymentMethodeForSubscribe:
        return MaterialPageRoute(builder: (_) => PaymentMethodeForSubscribe());
      case Routes.orderTrackingScreen:
        return MaterialPageRoute(
            builder: (_) => OrderTrackingScreen(
                  orderId: settings.arguments as String,
                  destination: settings.arguments as Address,
                  source: settings.arguments as Address,
                  createdDate: settings.arguments as DateTime,
                ));
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeView());

      //new
      case Routes.storeByCategoryScreen:
        return MaterialPageRoute(
            builder: (_) => StoreByCategryScreen(
                settings.arguments as Map<String, dynamic>));
      case Routes.unpaidItemScreen:
        return MaterialPageRoute(
            builder: (_) =>
                UnpaiadItemsScreen(settings.arguments as UnpaidOrder));
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.allProductScreen:
        return MaterialPageRoute(
            builder: (_) => AllProductScreen(
                  type: settings.arguments as String,
                ));
      case Routes.accountView:
        return MaterialPageRoute(builder: (_) => AccountView());
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put(LoginViewGetXController(context: context));
              return LoginView(role: settings.arguments as String);
            },
          ),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put(
                RegisterViewGetXController(
                  context: context,
                  role: args?['role'],
                ),
              );
              return RegisterView(
                role: settings.arguments as Map<String, dynamic>,
              );
            },
          ),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put(ForgotPasswordViewGetXController(context: context));
              return ForgetPasswordView(
                role: settings.arguments as String,
              );
            },
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put(ResetPasswordViewGetXController(context: context));
              return ResetPasswordView(
                role: settings.arguments as String,
              );
            },
          ),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.language:
        return MaterialPageRoute(builder: (_) => Language());
      case Routes.languageStore:
        return MaterialPageRoute(builder: (_) => LanguageStore());
      case Routes.subCategoriesRoute:
        return MaterialPageRoute(builder: (_) => const SubCategoriesView());
      case Routes.productRoute:
        return MaterialPageRoute(
          builder: (_) => ProductView(
            tag: settings.arguments as String,
          ),
        );
      case Routes.productView2:
        return MaterialPageRoute(
          builder: (_) => ProductView2(
            settings.arguments as Product2,
          ),
        );
      case Routes.checkOutRoute:
        return MaterialPageRoute(builder: (_) => CheckOutView());
      case Routes.checkOutConfirmRoute:
        return MaterialPageRoute(
            builder: (_) => CheckOutConfirmView(
                  orderId: settings.arguments as String,
                ));
      case Routes.orderInformationRoute:
        return MaterialPageRoute(builder: (_) => const OrderInformationView());
      case Routes.allRestaurantRoute:
        return MaterialPageRoute(builder: (_) => const AllRestaurantView());
      case Routes.aboutAppRoute:
        return MaterialPageRoute(builder: (_) => const AboutAppView());
      case Routes.addressesRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put(AddressesViewGetXController(context: context));
              return const AddressesView();
            },
          ),
        );
      case Routes.rewardsRoute:
        return MaterialPageRoute(builder: (_) => RewardsViewNew());
      case Routes.fAQRoute:
        return MaterialPageRoute(builder: (_) => const FAQView());

      case Routes.updateUserInfo:
        return MaterialPageRoute(builder: (_) => UpdateUserInfo());
      case Routes.sharaYourOpinionRoute:
        return MaterialPageRoute(builder: (_) => const SharaYourOpinionView());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case Routes.OrdersHistoryRoute:
        return MaterialPageRoute(builder: (_) => const OrdersHistoryView());
      case Routes.sitePrivacyRoute:
        return MaterialPageRoute(builder: (_) => const SitePrivacyView());
      case Routes.termsOfUseRoute:
        return MaterialPageRoute(builder: (_) => const TermsOfUseView());
      case Routes.offersRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<OffersScreenGetXController>(OffersScreenGetXController());
              return const OffersView();
            },
          ),
        );
      case Routes.myWalletRoute:
        return MaterialPageRoute(builder: (_) => const MyWalletView());
      case Routes.paymentMethodRoute:
        return MaterialPageRoute(
            builder: (_) => PaymentMethodView(
                // settings.arguments as Map<String,dynamic>
                ));
      case Routes.addOrEditAddressRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<AddOrEditAddressViewGetXController>(
                AddOrEditAddressViewGetXController(
                  context: context,
                  address: settings.arguments == null
                      ? null
                      : settings.arguments as Address,
                ),
              );
              return AddOrEditAddressView(
                  // settings.arguments as LocationData
                  );
            },
          ),
        );
      case Routes.products:
        return MaterialPageRoute(
          builder: (_) => ProductsScreen(
            // categoryId: settings.arguments as String,
            // categoryName: settings.arguments as String,
            category: settings.arguments as Map<String, dynamic>,
          ),
        );
      case Routes.myFavorite:
        return MaterialPageRoute(builder: (_) => MyFavoriteScreen());
      case Routes.rateUs:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<RateUsViewGetXController>(
                  RateUsViewGetXController(context: context));
              return RateUsView();
            },
          ),
        );
      case Routes.subscribeRoute:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<SubscribeViewGetXController>(
                SubscribeViewGetXController(context: _),
              );
              return const SubscribeView();
            },
          ),
        );

      //new
      case Routes.subscribeFromHomePage:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<SubscribeViewGetXController>(
                SubscribeViewGetXController(context: _),
              );
              return SubscribeViewFromHomePage();
            },
          ),
        );
      // case Routes.ordersToPay:
      //   return MaterialPageRoute(
      //     builder: (_) => Builder(
      //       builder: (context) {
      //         Get.put<OrdersToPayViewGetXController>(
      //           OrdersToPayViewGetXController(context: _),
      //         );
      //         return const OrdersToPayView();
      //       },
      //     ),
      //   );
      case Routes.ordersToPay:
        return MaterialPageRoute(
            builder: (_) => OrderToPay2(settings.arguments as String));
      case Routes.gifts:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<GiftsViewGetXController>(
                GiftsViewGetXController(context: _),
              );
              return const GiftsView();
            },
          ),
        );
      //seller
      case Routes.welcomeSellerRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeSellerView());

      case Routes.updateSellerInfo:
        return MaterialPageRoute(builder: (_) => UpdateInfoSeller());

      case Routes.storeSellerView:
        return MaterialPageRoute(builder: (_) => const StoreSellerView());
      case Routes.registerSellerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterSellerView());
      case Routes.subscriptionSellerRoute:
        return MaterialPageRoute(
          builder: (_) => const SubscriptionSellerView(),
        );
      case Routes.checkoutSellerRoute:
        return MaterialPageRoute(builder: (_) => const CheckoutSellerView());
      case Routes.choosePaymentMethodRoute:
        return MaterialPageRoute(
            builder: (_) => const ChoosePaymentMethodView());
      case Routes.addPaymentCardSelleRoute:
        return MaterialPageRoute(
            builder: (_) => Builder(builder: (context) {
                  Get.put<ProfileSettingGetxController>(
                      ProfileSettingGetxController());
                  return AddPaymentCardSellerView(settings.arguments as String);
                }));
      // MaterialPageRoute(
      //   builder: (_) => Builder(
      //     builder: (context) {
      //       Get.put<SubmitFormViewGetXController>(
      //         SubmitFormViewGetXController(context: _),
      //       );
      //       return SubmitFormView(settings.arguments as Map<String, dynamic>);
      //     },
      //   ),
      // );
      case Routes.paymentLinkSubscriptionSellerRoute:
        return MaterialPageRoute(
            builder: (_) => const PaymentLinkSubscriptionSellerView());
      case Routes.registerPaymentLinkSellerRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterPaymentLinkSellerView());
      case Routes.shopAddressSellerRoute:
        return MaterialPageRoute(
            builder: (_) => ShopAddressSellerView(
                settings.arguments as Map<String, dynamic>));
      case Routes.addBankAccountSellerRoute:
        return MaterialPageRoute(
            builder: (_) => AddBankAccountSellerView(
                  infoSubmit: settings.arguments as Map<String, dynamic>,
                ));
      case Routes.productsWithOutDetailsSellerRoute:
        return MaterialPageRoute(
            builder: (_) => const ProductsWithOutDetailsSellerView());
      case Routes.mainSellerRoute:
        return MaterialPageRoute(builder: (_) => const MainSellerView());
      case Routes.createPaymentLinkSellerRoute:
        return MaterialPageRoute(
            builder: (_) => const CreatePaymentLinkSellerView());
      case Routes.createPaymentLink2SellerRoute:
        return MaterialPageRoute(
            builder: (_) =>
                CreatePaymentLink2SellerView(settings.arguments as int));
      case Routes.addItemSellerRoute:
        return MaterialPageRoute(
            builder: (_) => AddItemSellerView(settings.arguments as bool));

      case Routes.sellerStatus:
        return MaterialPageRoute(builder: (_) => SellerStatus());

      case Routes.addItem2SellerRoute:
        return MaterialPageRoute(
            builder: (_) => AddItem2SellerView(settings.arguments as bool));
      case Routes.payLaterRoute:
        return MaterialPageRoute(builder: (_) => const PayLaterView());
      case Routes.couponsRoute:
        return MaterialPageRoute(builder: (_) => const CouponsView());
      case Routes.submitForm:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) {
              Get.put<SubmitFormViewGetXController>(
                SubmitFormViewGetXController(context: _),
              );
              return SubmitFormView(settings.arguments as Map<String, dynamic>);
            },
          ),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text(AppString.noRouteFound))),
    );
  }
}
