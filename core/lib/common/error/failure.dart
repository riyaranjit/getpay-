abstract class Failure {
  String _code;
  String _message;

  Failure(this._code, this._message);

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }
}

class ApiFailure extends Failure {
  ApiFailure(String code, String message) : super(code, message);
}
