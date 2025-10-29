extension EmailValidationExtension on String {
  bool get isValidEmail => RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(this);
}

extension PasswordValidationExtension on String {
  bool get isValidPassword => RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(this);
}

extension MobileValidationExtension on String {
  bool get isValidMobile => RegExp(r"^\d{10}$").hasMatch(this);
}

extension NameValidationExtension on String {
  bool get isValidName => RegExp(r"^[a-zA-Z ]+$").hasMatch(this);
}

