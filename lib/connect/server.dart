import 'dart:convert';

import 'package:http/http.dart' as http;

class serverApi {
  postRequest(String uri, Map map) async {
    var url = Uri.parse(uri);

    try {
      var response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        return responseBody;
      } else {
        print("statusCode:${response.statusCode}");
      }
    } catch (e) {
      print("${e}");
    }
  }

  getRequest(String uri) async {
    var url = Uri.parse(uri);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        return responseBody;
      } else {
        print("statusCode:${response.statusCode}");
      }
    } catch (e) {
      print("${e}");
    }
  }
}
