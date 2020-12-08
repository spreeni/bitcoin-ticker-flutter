import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url, this.headers});

  String url;
  Map<String, String> headers;

  dynamic getData() async {
    http.Response res = await http.get(this.url, headers: this.headers);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print('Error: Request returned status code ${res.statusCode}');
    }
  }
}
