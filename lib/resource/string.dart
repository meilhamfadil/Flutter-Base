class AppString {
  static String appName = "Flutter Firebase";
}

extension boolExtension on bool {
  T nullOrValue<T>(value) {
    return (this) ? null : value;
  }
}

extension StringExtension on String {
  bool validateEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
