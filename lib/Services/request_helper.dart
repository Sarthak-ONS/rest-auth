import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_auth/Services/app_exceptions.dart';

class RequestHelper {
  Future sendPostRequest(
      {required String? url,
      required Map<String, Object> body,
      BuildContext? context}) async {
    // Sending Post Request
    try {
      http.Response response = await http
          .post(
        Uri.parse(url!),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          return http.Response('Request Timeout', 401);
        },
      );
      return await _processResponse(response);
    }
    // On Custom Exceptions
    on AppException catch (e) {
      if (e.message.toString() == 'EMAIL_EXISTS') {
        showErrorBox(context,
            'An account with this email already exists. \n Plesae login!');
      }
      if (e.message.toString() == 'EMAIL_NOT_FOUND') {
        showErrorBox(
            context, "We couldn't find an account attached to this email.");
      }
      if (e.message.toString() == 'INVALID_PASSWORD') {
        showErrorBox(context, "Wrong Password");
      }
      if (e.message.toString() == 'USER_DISABLED') {
        showErrorBox(context, "Your account is under surviliance");
      }
      if (e.message.toString() == 'OPERATION_NOT_ALLOWED') {
        showErrorBox(context, "Please try again!");
      }
      if (e.message.toString() == 'INVALID_EMAIL') {
        showErrorBox(context, "Please enter a valid email");
      }
      //INVALID_EMAIL
    }
    // Handling any type of errors.
    catch (e) {
      print("Error is catched successfully!");
      print((e.toString()));
    }
    // Just ending up with finally statements
     finally {
      print("Request is completed successfully");
    }
  }

  dynamic _processResponse(http.Response response) {
    final decodedData = json.decode(response.body);
    if (decodedData['error'] != null) {
      throw AppException(decodedData['error']['message']);
    }
    print(response.body);
    return response.body;
  }

  //Error dialog box
  static dynamic showErrorBox(BuildContext? context, String errorMessage) {
    showDialog(
      context: context!,
      builder: (_) => CupertinoAlertDialog(
        title: const Icon(
          Icons.error_outline_rounded,
          color: Colors.black,
          size: 50,
        ),
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                style:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
