import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:berita/models/index.dart';

class API {
  Future getData(String q) async {
    String apikey = "";
    String baseUrl = "https://newsapi.org/v2/everything?q=$q&apiKey=$apikey";
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final parsed =
            jsonDecode(response.body)['articles'].cast<Map<String, dynamic>>();
        List<Berita> berita =
            parsed.map<Berita>((json) => Berita.fromJson(json)).toList();
        return berita;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
