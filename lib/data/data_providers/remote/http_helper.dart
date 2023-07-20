import 'dart:convert';
import 'package:magdsoft_flutter_structure/constants/end_points.dart';
import 'package:magdsoft_flutter_structure/data/network/responses/help_response.dart';
import 'package:magdsoft_flutter_structure/data/network/responses/product_response.dart';
import 'package:http/http.dart' as http;
import 'package:magdsoft_flutter_structure/data/network/responses/verify_phone_response.dart';

class HttpHelper {
  static Future<ProductsResponseModel> getProducts() async {
    final url = Uri.http(apiHost, "/api/getProducts");
    var response = await http.get(url);
    var responsebody = response.body;
    var json = jsonDecode(responsebody);
    return ProductsResponseModel.fromJson(json);
  }

  static Future<HelpResponse> getHelp() async {
    final url = Uri.http(apiHost, "/api/getHelp");
    var response = await http.get(url);
    var responsebody = response.body;
    var json = jsonDecode(responsebody);
    return HelpResponse.fromJson(json);
  }

  static Future<VerifyPhoneResponse> verifyPhone(
      String name, String phone) async {
    final response = await http.post(
      Uri.parse('https://magdsoft.ahmedshawky.fun/api/verifyPhone'),
      body: {'name': name, 'phone': phone},
    );
    if (response.statusCode == 200) {
      // If the server succeded
      // then parse the JSON.
      return VerifyPhoneResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server failed to auth
      // then throw an exception.
      throw Exception('Failed to verify phone.');
    }
  }

  // static Future<AccountResponse> signUser(String name, String phone) {
  //    http.post(
  //       Uri.parse('https://magdsoft.ahmedshawky.fun/api/verifyPhone'),
  //       body: {'name': name, 'phone': phone});
  //       return AccountResponse.fromJson(json)
  // }
}
