import 'package:core/common/rest/request_header.dart';
import 'package:flutter/cupertino.dart';

class RestRequestBody<T> {
  String _url;
  List<RequestHeader> _requestHeaders;
  T _body;
  String _formData;

  RestRequestBody(
      {@required String url,
      List<RequestHeader> requestHeaders,
      T body,
      String formData})
      : _url = url,
        _requestHeaders = requestHeaders,
        _body = body,
        _formData = formData;

  String get formData => _formData;

  set formData(String value) {
    _formData = value;
  }

  T get body => _body;

  set body(T value) {
    _body = value;
  }

  List<RequestHeader> get requestHeaders => _requestHeaders;

  set requestHeaders(List<RequestHeader> value) {
    _requestHeaders = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }
}
