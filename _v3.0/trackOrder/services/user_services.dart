import 'dart:convert';

import "package:http/http.dart" as http;

class UserServices {
  Future<List<String>> getUser() async {
    try {
      final http.Response res =
          await http.get(Uri.parse("https://randomuser.me/api/?result=1"));

      if (res.statusCode == 200) {
        Map data = jsonDecode(res.body);

        String name =
            "${data["results"][0]["name"]["first"].toString()} ${data["results"][0]["name"]["last"].toString()}";
        String email = "${data["results"][0]["email"]}";
        String picture = "${data["results"][0]["picture"]["medium"]}";
        List<String> user = [name, email, picture];

        return user;
      }

      return Future.error(res.statusCode);
    } catch (e) {
   
      return Future.error(e.toString());
    }
  }
}
