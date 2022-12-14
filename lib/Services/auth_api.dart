import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rest_auth/Services/request_helper.dart';

class AuthApi extends ChangeNotifier {
  String? _token;

  static var signupurl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${dotenv.get("WEB_API_KEY")}";

  // Creates a new user
  Future<void> createUserWithEmailAndPassword(
      {String? firstname,
      String? lstName,
      String? email,
      String? password,
      BuildContext? context}) async {
    try {
      print("Started Seinding request");
      Map<String, Object> bodyMap = {
        "email": email!,
        "password": password!,
      };
      final data = await RequestHelper()
          .sendPostRequest(url: signupurl, body: bodyMap, context: context);
      if (data == null) return;

      _token = jsonDecode(data)['idToken'];
    } catch (e) {
      print(e.toString());
    }
  }
}
