import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app_exceptions.dart';

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
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          return http.Response('Request Timeout', 401);
        },
      );
      _processResponse(response);
    } on EmailAlreadyExistsException catch (e) {
      print(e);
      showErrorBox(context, "An account with this email already exists");
    } on TimeoutException {
      showErrorBox(context, 'Request time out, Please try again!');
    } catch (e) {
      print("Error is catched successfully!");
      print((e.toString()));
    }
  }

  //Error dialog box
  dynamic showErrorBox(BuildContext? context, String errorMessage) {
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
        print(response.body);
        break;
      case 400:
        final decodedData = jsonDecode(response.body);
        if (decodedData['error']['message'] == 'EMAIL_EXISTS') {
          throw EmailAlreadyExistsException(decodedData['error']['message']);
        }
        if (decodedData['error']['message'] == 'TOO_MANY_ATTEMPTS_TRY_LATER') {
          throw TooManyAttemptsException(decodedData['error']['message']);
        }
        return;
      case 401:
        throw TimeoutException('Reqest timeout, Please try again.');
      case 500:
        throw IntervalServerErrorException(
            'Server is down!, Please try after sometime');

      default:
        break;
    }
  }
}
