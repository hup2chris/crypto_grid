import 'package:url_launcher/url_launcher.dart';

class Hup2 {

  launchPage (String wp) async {
    String url = 'https://hup2.com';

    if (wp == 'Hup2') url = 'https://hup2.com';
    if (wp == 'pl') url = 'https://hup2.com/pl';
    if (wp == 'hr') url = 'https://hup2.com/hr';
    if (wp == 'ebpc') url = 'https://hup2.com/ebpc';
    if (wp == 'https://icons8.com') url = 'https://icons8.com';

    try {
      await launch(url);
    }
    catch (e) {
      print(e);
    }
  }

}