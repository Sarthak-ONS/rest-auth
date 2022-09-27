import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestHelper {
  Future sendPostRequest(
      {required String? url,
      required Map<String, Object> body,
      BuildContext? context}) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse(url!),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      final decodedData = jsonDecode(response.body);
      print("The status code is ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        _processResponse(response);
      }
    } on EmailAlreadyExistsException {
      showErrorBox(context, "An account with this email already exists");
    } catch (e) {
      print("Error is catched successfully!");
      print((e.toString()));
    }
  }

  showErrorBox(BuildContext? context, String errorMessage) {
    showDialog(
      context: context!,
      builder: (_) => AlertDialog(
        title: const Icon(
          Icons.error_outline_rounded,
          color: Colors.black,
          size: 50,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'An account with this email already exists',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        final decodedData = jsonDecode(response.body);
        if (decodedData['error']['message'] == 'EMAIL_EXISTS') {
          throw EmailAlreadyExistsException(decodedData['error']['message']);
        }
        if (decodedData['error']['message'] == 'TOO_MANY_ATTEMPTS_TRY_LATER') {
          throw TooManyAttemptsException(decodedData['error']['message']);
        }
        return;
      default:
        break;
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class EmailAlreadyExistsException extends AppException {
  EmailAlreadyExistsException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class TooManyAttemptsException extends AppException {
  TooManyAttemptsException([String? message, String? url])
      : super(message, 'Bad request', url);
}
