class Validations {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }

    // Corrected regex
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Invalid email format';
    }

    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return 'Mobile is required';
    }
    if (value.length < 10) {
      return 'Mobile must be at least 10 characters long';
    }
    return null;
  }



}
