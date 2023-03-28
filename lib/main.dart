import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:share/share.dart';

import 'app/app.dart';
import 'app/preferences/shared_pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  await dotenv.load(fileName: "assets/.env");
  // Stripe.publishableKey = 'pk_test_51MLP4SIQef6xe4xwQy3UczJ4PIOWi91gE0m5QrAtqkBaSHO0WbeVLXMuIc9DaqPqpJ4UgFnYU2o62M2NShZ3nYi700RsRhild8';
  

  // Stripe.publishableKey = 'pk_test_51MLP4SIQef6xe4xwQy3UczJ4PIOWi91gE0m5QrAtqkBaSHO0WbeVLXMuIc9DaqPqpJ4UgFnYU2o62M2NShZ3nYi700RsRhild8';
  // Stripe.merchantIdentifier = 'any string works';
  // await Stripe.instance.applySettings();

  // SystemChannels.platform.invokeMethod('SystemChrome.setPreferredOrientations', [DeviceOrientation.portraitUp])
  //     .then((_) {
  //   runApp(MyApp());
  // });
  // Share.share('Initial Share');


  runApp(
      MyApp()
  );
}
