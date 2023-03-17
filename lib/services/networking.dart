import 'package:http/http.dart' as http;
import 'dart:convert';

class networkHelper {
  final String? url;
  networkHelper({this.url});
  Future getData() async {
    var uri = Uri.parse(url!);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      //String data = response.body;
      var data = jsonDecode(response.body);
      return data;
      // var name = dat['name'];
      // var weatherDescription = dat['weather'][0]['description'];
      // print(weatherDescription);
      // print(name);
    } else {
      print(response.statusCode);
      print(5);
    }
  }
}
