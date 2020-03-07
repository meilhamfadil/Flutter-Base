class AppString {
  static String appName = "Flutter Firebase";
}

extension boolExtension on bool {
  T nullOrValue<T>(value) {
    return (this) ? null : value;
  }
}

extension Validator on String {
  FormValidator validation() {
    return FormValidator(this);
  }
}

class FormValidator {
  String _value;
  String _message;

  FormValidator(String message) {
    _value = message;
  }

  FormValidator required({String message}) {
    if (_value.isEmpty && _message == null) _message = message;
    return this;
  }

  FormValidator maxLength({int length, String message}) {
    if (_value.length > length && _message == null) _message = message;
    return this;
  }

  FormValidator minLength({int length, String message}) {
    if (_value.length < length && _message == null) _message = message;
    return this;
  }

  FormValidator email({String message}) {
    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(_value) &&
        _message == null) _message = message;
    return this;
  }

  String validate() {
    String message = _message;
    _message = null;
    return message;
  }
}
