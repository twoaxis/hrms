class AuthValidators {
  static String? emailValidators(String? input, bool emailSubmitted) {
    if (emailSubmitted) {
      if (input == null || input.isEmpty) {
        return 'Email address is required.';
      }
      final bool emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(input);
      if (!emailRegExp) {
        return 'Please enter a valid email address.';
      }
      return null;
    }
    return null;
  }

  static String? passwordValidators(String? input, bool passwordSubmitted) {
    if (passwordSubmitted) {
      if (input == null || input.isEmpty) {
        return 'Password is required.';
      }
      if (input.length < 6) {
        return 'Password must be at least 6 characters.';
      }
      return null;
    }
    return null;
  }
}
