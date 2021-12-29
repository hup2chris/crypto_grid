import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:crypto_grid/hid/hid.dart';


const ccAllAPIURL = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN';
const apiKey = kApiKey;

class CoinData {

  Future getCoinData() async {

    //Map<String, String> prices = {'Chris':'1775',};
    String requestURL = ccAllAPIURL;
    var decodedData;

    requestURL = '$requestURL&apikey=$apiKey';
    // print(requestURL);
    http.Response response = await http.get(Uri.parse(requestURL));

    print('got to getCoinData after url');

    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
//      print(decodedData);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
    return decodedData;
  }
}
