import 'package:flutter/material.dart';
import 'package:crypto_grid/cg_screen.dart';
//import 'package:crypto_grid/about.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universal_platform/universal_platform.dart';

void main() {

  if (UniversalPlatform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
  }

  //runApp(Crypto_Grid());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//class Crypto_Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: PriceScreen.id,
      routes: {
        PriceScreen.id: (context) => PriceScreen(),
        //About.id: (context) => About(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}