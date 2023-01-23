class ServerException implements Exception {
  String _code;
  String _message;

  ServerException(this._code, this._message);

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }
}
