class RequestHeader {
  String _key;
  String _value;

  RequestHeader(this._key, this._value);

  String get value => _value;

  String get key => _key;

  @override
  String toString() {
    return 'key = $key >> value = $value';
  }
}