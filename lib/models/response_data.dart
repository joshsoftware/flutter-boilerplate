import 'dart:convert';

import 'package:http/http.dart' as http;

class ResponseData {
  int statusCode;
  bool ok;
  bool okAndContainsData;
  var data;
  var message;
  ResponseErrors errors;
  String rawResponseBody;

  ResponseData(
      {this.statusCode, this.data, this.message, this.errors, this.ok: false, this.okAndContainsData: false, this.rawResponseBody});

  factory ResponseData.fromResponse(http.Response response) {
    var parsedJson = jsonDecode(response.body);
    return ResponseData(
      statusCode: response.statusCode,
      ok: (response.statusCode == 200 || response.statusCode == 201),
      data: parsedJson['data'] != null ? parsedJson['data'] : null,
      rawResponseBody: response.body != null ? response.body : null,
      okAndContainsData: (response.statusCode == 200 || response.statusCode == 201) && (parsedJson['data'] != null),
      message: parsedJson['message'] != null ? parsedJson['message'] : "",
      errors: parsedJson['errors'] != null
          ? parsedJson['errors'].runtimeType == String
              ? new ResponseErrors(message: parsedJson['errors'])
              : ResponseErrors.fromJson(parsedJson['errors'])
          : parsedJson['error'] != null
              ? ResponseErrors(message: parsedJson['error'])
              : null,
    );
  }
}

class ResponseErrors {
  String message;

  ResponseErrors({
    this.message,
  });

  factory ResponseErrors.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseErrors(
      message: parsedJson['message'] != null ? parsedJson['message'] : "",
    );
  }
}
