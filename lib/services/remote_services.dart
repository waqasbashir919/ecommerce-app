import 'dart:convert';

import 'package:ecommerce_app/model/product.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<Post?> getPosts() async {
    try {
      var uri = Uri.parse(
          'https://e-commerce-api-bulega.herokuapp.com/api/v1/products');
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return postFromJson(jsonString);
      }
    } catch (e) {
      print(e);
    }
  }
}
