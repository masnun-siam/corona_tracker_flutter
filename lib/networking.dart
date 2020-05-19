
import 'dart:convert';

import 'package:http/http.dart';

class Networking {
  static Future getDataLocal (String country) async {
    Response response = await get('https://disease.sh/v2/countries/$country?yesterday=false&strict=true');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  static Future getDataGlobal () async {
    Response response = await get('https://disease.sh/v2/all');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}