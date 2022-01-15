import 'package:flutter/material.dart';
import 'package:crypto_grid/hup2.dart';

class About extends StatefulWidget {
  static const String id = 'About';

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
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
              PopupMenuItem(child: Text("Home"), value: "PriceScreen"),
              PopupMenuItem(child: Text("Hup2"), value: "Hup2"),
              PopupMenuItem(child: Text("Football League Tables"), value: "pl"),
              PopupMenuItem(child: Text("Horse Racing Tables"), value: "hr"),
              PopupMenuItem(child: Text("EBook Price Comparison"), value: "ebpc"),
            ],
            onSelected: (route) {
              if(route != 'PriceScreen')
                Hup2().launchPage(route.toString());
              else
                //Navigator.pushNamed(context, route.toString());
                Navigator.pop(context);
            },
          ),//actions widget in appbar
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25.0),
                alignment: Alignment.center,
                child: Text(
                  'About Crypto Grid News',
                  style: TextStyle(
                    fontFamily: 'Balsamiq Sans',
                    fontSize: 23.0,
                    color: Color(0xFFCFD8DC),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: /*Text(
                  'Crypto Grid News displays you the latest Crypto News \n\n'
                  'Refine by News Source or Crypto Type \n\n'
                  'Thanks to <a href="https://icons8.com">Icons8</a> for the Icons',
                  style: TextStyle(
                    fontFamily: 'Balsamiq Sans',
                    fontSize: 17.0,
                    color: Color(0xFFCFD8DC),
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Text(
                      'Crypto Grid News displays you the latest Crypto News \n\n'
                          'Refine by News Source or Crypto Type \n\n',
                      style: TextStyle(
                        fontFamily: 'Balsamiq Sans',
                        fontSize: 17.0,
                        color: Color(0xFFCFD8DC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: _launchURLBrowser,
                      child: Text('Thanks to Icons8 for the Icons'),
                      textColor: Colors.black,
                      padding: const EdgeInsets.all(5.0),
                    ),
                    Container(
                      height: 20.0,
                    ),
                  ],
                ),
    ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURLBrowser() async {
  const url = 'https://icons8.com';

  Hup2().launchPage(url);
}