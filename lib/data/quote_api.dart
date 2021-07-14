import 'dart:async';
import 'package:http/http.dart' as http;

class CharacterApi {
  static Future getQuotes() {
    return http.get(Uri.parse("https://type.fit/api/quotes"));
  }
}