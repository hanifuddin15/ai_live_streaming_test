class CoreValidator {
  /*
   * ---> Validate required field 
   */
  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /*
   * ---> Validate email field 
   */
  static String? emailField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /*
   * ---> Validate password field 
   */
  static String? passwordField(String? value, {int minLength = 4}) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }

    return null;
  }

  static String? strongPasswordField(String? value, {int minLength = 4}) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }

    /*
     * ---> Optional: Strong password check 
     */
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    if (!regex.hasMatch(value)) {
      return 'Password must contain letters & numbers';
    }

    return null;
  }

  /*
   * ---> Validate phone number 
   */
  static String? phoneField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }

    return null;
  }
}
