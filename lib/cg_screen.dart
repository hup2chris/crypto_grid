import 'package:flutter/material.dart';
import 'package:crypto_grid/coin_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto_grid/hup2.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'dart:io' show Platform;
import 'package:universal_platform/universal_platform.dart';
//import 'package:crypto_grid/about.dart';
//import 'package:webview_flutter/webview_flutter.dart';

List<String> sourceList = [];
List<String> categoriesList = [];
List<String> cryptoList = ['BTC','ADA', 'XRP','COMP','XLM','ETH', 'GRT', 'FET',
  'AMP', 'LTC', 'TRX', 'ZEC', 'NEO','BAT'];
List<String> currenciesList = [
 /* 'AUD',
  'CAD',
  'EUR',
  'GBP',
  'HKD',
  'JPY',
  'NZD',
  'USD'*/
];

String vsource = 'Source';
String vcategories = 'Categories';
Color vmcol = Colors.white;

String gtUrl = 'https://hup2.com';

//Color logIn = Colors.lightBlue;

late InterstitialAd _interstitialAd;
//bool _interstitialReady = false;

// TODO: Add _isInterstitialAdReady
bool _isInterstitialAdReady = false;

@override
void dispose() {
  _interstitialAd.dispose();
 // super.dispose();
}

class PriceScreen extends StatefulWidget {
  static const String id = 'Price_Screen';

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedFv = 'BTC';
  String loaded = 'No';

 // final Completer<WebViewController> _controller = Completer<WebViewController>();
 // final Completer<WebViewController> _controller = Completer<WebViewController>();

  DropdownButton<String> androidDropdown(String fv, List<String> ls) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    selectedFv = fv;
    for (String source in ls) {
      var newItem = DropdownMenuItem(
        child: Text(source),
        value: source,
      );
      dropdownItems.add(newItem);
    }

  //  print(ls.toString());

    return DropdownButton<String>(
      value: selectedFv,
      items: dropdownItems,
      underline: SizedBox(),
      onChanged: (value) {
        setState(() {
          selectedFv = value.toString();
          if (ls.toString() == sourceList.toString())
            vsource = value.toString();
          else
            vcategories = value.toString();
          getData();
        });
      },
    );
  }

 /* CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }*/

  //String value = '?';
  Map value = {};

  void getData() async {

    sourceList = []; categoriesList = [];

    try {
      Map data = await CoinData().getCoinData();//selectedCurrency);
      //print(data.keys);
      setState(() {
        value = data;

        for (int i = 0; i < value['Data'].length; i++) {
          if ((vsource == value['Data'][i]['source'] || vsource == 'Source') &&
              (value['Data'][i]['title'].contains(vcategories) ||
                  value['Data'][i]['body'].contains(vcategories) ||
                  value['Data'][i]['tags'].contains(vcategories) ||
                  value['Data'][i]['categories'].contains(vcategories) ||
                  vcategories == 'Categories')
          ) {
           // print('vsource is $vsource and vcategories is $vcategories');
        //    print('$vsource == ${value['Data'][i]['source']} || $vsource == ');

            if (!currenciesList.contains(value['Data'][i]['categories']))
              currenciesList.add(value['Data'][i]['categories']);

            if (sourceList.isEmpty)
              sourceList.add('Source');

            if (!sourceList.contains(value['Data'][i]['source']))
              sourceList.add(value['Data'][i]['source']);

            sourceList.sort();

            if (categoriesList.isEmpty)
              categoriesList.add('Categories');

            for (int c = 0; c < cryptoList.length; c++) {
              if (value['Data'][i]['title'].contains(cryptoList[c]) ||
                  value['Data'][i]['body'].contains(cryptoList[c]) ||
                  value['Data'][i]['tags'].contains(cryptoList[c]) ||
                  value['Data'][i]['categories'].contains(cryptoList[c])) {
                if (!categoriesList.contains(cryptoList[c]))
                  categoriesList.add(cryptoList[c]);
              }
            }
          }
        }

        loaded = 'Yes';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List <CryptoCard> getCryptoCard() {
    List <CryptoCard> cc = [];

    for (int i = 0; i < value['Data'].length; i++) {

    //  print('vsource is $vsource');

      if ((vsource == value['Data'][i]['source'] || vsource == 'Source') &&
          (value['Data'][i]['title'].contains(vcategories) ||
              value['Data'][i]['body'].contains(vcategories) ||
              value['Data'][i]['tags'].contains(vcategories) ||
              value['Data'][i]['categories'].contains(vcategories) ||
              vcategories == 'Categories')
      ) {
        cc.add(
            CryptoCard(title: value.isEmpty ? '?' : value['Data'][i]['title'],
              url: value['Data'][i]['url'],
              img: value['Data'][i]['imageurl']));
      }
  }
   // print(source.toString());
   return cc;
  }



    @override
  Widget build(BuildContext context) {

      // if (Platform.isAndroid) {
      // if (Platform.operatingSystem == 'android') {
      if (UniversalPlatform.isAndroid) {
        _interstitialAd =
        new InterstitialAd(adUnitId: 'ca-app-pub-7306563248556636/9119361488',
       // 'ca-app-pub-3940256099942544/1033173712',
            //InterstitialAd.testAdUnitId,
            listener: AdListener(
              onAdLoaded: (_) {
                _isInterstitialAdReady = true;
              },
              onAdFailedToLoad: (ad, err) {
                print('Failed to load an interstitial ad: ${err.message}');
                _isInterstitialAdReady = false;
                ad.dispose();
              },
              onAdClosed: (_) {
                //_moveToHome();
                //Navigator.pushNamed(context, 'MainScreen');
                //Navigator.of(context).popUntil(ModalRoute.withName('PriceScreen'));
                //Navigator.defaultRouteName;

                _interstitialAd.dispose();

                _interstitialAd.load();
                goToPage(gtUrl);
              },
            ),
            request: AdRequest());
        _interstitialAd.load();
      }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,//logIn,
        title: Row(
          children: [
            Image.asset('images/appstore.png',
            width: 50, height: 50,),
            //Text('🪙 Crypto Grid News',
            Text('  Crypto Grid News',
                      style: TextStyle(color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 23.0),),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(child: Text("About"), value: "About"),
              PopupMenuItem(child: Text("Hup2"), value: "Hup2"),
              PopupMenuItem(child: Text("Football League Tables"), value: "pl"),
              PopupMenuItem(child: Text("Horse Racing Tables"), value: "hr"),
              PopupMenuItem(child: Text("EBook Price Comparison"), value: "ebpc"),
            ],
            onSelected: (route) {
              if(route != 'About')
                Hup2().launchPage(route.toString());
              else
                Navigator.pushNamed(context, route.toString());
            },
          ),//actions widget in appbar
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
             // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width/2,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 5.0),
                color: Colors.blueGrey,
                child: //Platform.isIOS ? iOSPicker() :
                loaded != 'Yes' ? SpinKitChasingDots(
                  color: Colors.blueGrey,
                  size: 100.0,) : androidDropdown(vsource, sourceList),
          ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width/2,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 5.0),
                  color: Colors.blueGrey,
                  child: //Platform.isIOS ? iOSPicker() :
                  loaded != 'Yes' ? SpinKitChasingDots(
                    color: Colors.blueGrey,
                    size: 100.0,) : androidDropdown(vcategories, categoriesList),
                ),
              ],
            ),
          Expanded(child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: vmcol,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )
            ),
            child: loaded != 'Yes' ? SpinKitChasingDots(
              color: Colors.blueGrey,
              size: 100.0,) :
                  TasksList(getCryptoCard()),
          )),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  CryptoCard({required this.title, required this.url, required this.img});

  final String title;
  final String url;
  final String img;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeightHei = (size.height - kToolbarHeight - 30) / 2;
    final double itemWidthHei = size.width / 2;

    return
      GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        childAspectRatio: (itemWidthHei / itemHeightHei),
        // Generate 100 widgets that display their index in the List.
        children: List.generate(2, (index) {

          return
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                // Set a border for each side of the box
                border: Border(
                  top: BorderSide(width: 5,
                      color: Colors.white),
                  right: BorderSide(width: 5,
                      color: Colors.white),
                ),
              ),
              child: Text('chris',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.red,
                ),
              ),
            );
          // }
        }),
      );
  }
}

class TasksList extends StatelessWidget {
  //final List<String> items = List<String>.generate(10000, (i) => "Item $i");

  TasksList(this.cc);

  final List <CryptoCard> cc;

  /*@override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return CryptoCard(value: cc[index].value, selectedCurrency: cc[index].selectedCurrency,
        cryptoCurrency: cc[index].cryptoCurrency, day1: cc[index].day1,
        num: cc[index].num,);
    },
        itemCount: cc.length,
    );
  }*/
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeightHei = (size.height - kToolbarHeight - 30) / (size.width > 1000 ? 3 : 2);
    final double itemWidthHei = size.width / 2;


    return
      GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: size.width > 1000 ? 3 : 2,
        childAspectRatio: (itemWidthHei / itemHeightHei),
        // Generate 100 widgets that display their index in the List.
        children: List.generate(cc.length, (index) {

          return
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: vmcol,//blue[100],
                  // Set a border for each side of the box
                  border: Border(
                    top: BorderSide(width: 5, color: Colors.blueGrey),
                    right: BorderSide(width: 5, color: Colors.blueGrey),
                  ),
                ),
                child: size.width < 1000 ? Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                Image.network(
                  cc[index].img,
                  width: (MediaQuery.of(context).size.width)/5,
                  height: (MediaQuery.of(context).size.height)/5,
                 // fit: BoxFit.scaleDown,//BoxFit.contain,
                  alignment: Alignment.bottomLeft,
                ),
                    Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cc[index].title,
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )]) :
                Row(
                  children: [
                    Image.network(
                      cc[index].img,
                      width: (MediaQuery.of(context).size.width)/10,
                      height: (MediaQuery.of(context).size.height)/10,
                      // fit: BoxFit.scaleDown,//BoxFit.contain,
                      alignment: Alignment.topLeft,
                    ),
                  /*  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:*/
                   Expanded(
                     child: Text(cc[index].title,
                          //overflow: TextOverflow.visible,
                         // softWrap: true,
                          style: TextStyle(
                          //  fontSize: 23.0,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                         //   overflow: TextOverflow.ellipsis,
                          ),
                       //   textAlign: TextAlign.center,
                        ),
                   ),
                  //  )
                  ],
                ),
              ),
              onTap: //() //{ launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');},
                 () async {

          //      print('system is ${Platform.operatingSystem}');

    //if (Platform.isAndroid) {
   // if (Platform.operatingSystem == 'android') {
    if (UniversalPlatform.isAndroid) {
    //  _interstitialAd.isLoaded().then((value) => print('got to nft '));
      //print('got to _isInterstitialAdReady and it is $_isInterstitialAdReady');

      //print('  _interstitialAd.isLoaded() ${ _interstitialAd.isLoaded().toString()}');
      _interstitialAd.load();

      if (_isInterstitialAdReady) {
       // print('got to showing ');

        gtUrl = cc[index].url;
        _interstitialAd.show();;
      //  _interstitialAd.dispose();
        //_interstitialAd.load();
      }
    }
    else {
      goToPage(cc[index].url);
      //goToPage(gtUrl);
    }

                     //  else {
                     //    goToPage(cc[index].url);
                     //  }
                          }
            );
          // }
        }),
      );
  }
}

goToPage(String url) async {

  //String url = cc[index].url;
  try {              await launch(url);            }
  catch (e) {              print(e);            }
}
