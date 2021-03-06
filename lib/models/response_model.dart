class ResponseModel {
  final bool _isSuccess;
  final String _message;

  ResponseModel(this._isSuccess, this._message); // if private variable u can't use {}

  String get message => _message;

  bool get isSuccess => _isSuccess;
}
