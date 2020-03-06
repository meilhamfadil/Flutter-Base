import 'dart:async';

class AuthBloc {
  bool _showPassword = false;

  final _showPasswordStreamController = StreamController<bool>();

  Stream<bool> get showPasswordStream => _showPasswordStreamController.stream;

  StreamSink<bool> get showPasswordSink => _showPasswordStreamController.sink;

  AuthBloc() {
    _showPasswordStreamController.add(_showPassword);
    _showPasswordStreamController.stream.listen(_toggleShowPassword);
  }

  _toggleShowPassword(bool value) {
    _showPassword = !_showPassword;
  }

  void dispose() {
    _showPasswordStreamController.close();
  }
}
