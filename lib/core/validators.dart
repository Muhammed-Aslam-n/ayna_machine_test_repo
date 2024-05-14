
import 'package:flutter/services.dart';



String getErrorMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case 'invalid-credential':
      return 'Invalid credentials';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'user-disabled':
      return 'Your account has been disabled. Please contact support.';
    case 'user-not-found':
      return 'No account found with this email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'weak-password':
      return 'The password is too weak. Please choose a stronger one.';
    case 'email-already-in-use':
      return 'An account already exists with this email.';
    case 'operation-not-allowed':
      return 'This operation is not allowed.';
    case 'requires-recent-login':
      return 'Please logout and log in again to continue';
    case 'too-many-requests':
      return 'Too many requests. Please try again later.';
    case 'network-request-failed':
      return 'Network error. Please check your internet connection.';
    default:
      return 'An unknown error occurred. Please try again.';
  }
}


extension PasswordValidation on String {
  String? get invalidPasswordReason {
    if (isEmpty) return "Password can't be empty";
    if (length < 5) return "Password must be at least 5 characters long";
    if (length > 8) return "Password must be at most 8 characters long";
    if (contains(' ')) return "Password should not contain spaces";
    return null;
  }
}

class PasswordInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp noSpace = RegExp(r'^[^ ]*$');

    if (newValue.text.isEmpty) {
      return const TextEditingValue(); // Allow empty text
    } else if (newValue.text.length > 8) {
      // Return old value if the new value is too long
      return oldValue.copyWith(text: oldValue.text);
    } else if (!noSpace.hasMatch(newValue.text)) {
      // Return old value if the new value contains spaces
      return oldValue.copyWith(text: oldValue.text);
    } else {
      // Allow the new value
      return newValue;
    }
  }
}

extension EmailValidation on String {
  String? get invalidEmailReason {
    if (isEmpty) return "Email can't be empty";
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(this)) {
      return "Invalid email format";
    }
    return null;
  }
}

class EmailInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final regExp = RegExp(r'^[a-zA-Z0-9.@_-]+$');

    if (regExp.hasMatch(newValue.text)) {
      return newValue; // Return the new value if it matches the email pattern
    } else {
      // Return the old value if the new value doesn't match the pattern
      return oldValue;
    }
  }
}


extension NameValidation on String {
  String? validateName() {
    // Check if the value is empty
    if (isEmpty) {
      return 'Please enter your name';
    }
    // Define your regex pattern for the name
    final regExp = RegExp(r'^[a-zA-Z\s]+$');
    // Check if the value matches the regex pattern
    if (!regExp.hasMatch(this)) {
      return 'Please enter a valid name';
    }
    // If the value passes all checks, return null indicating no error
    return null;
  }

  String? validateRegisterNumber() {
    if (isEmpty) {
      return 'Please enter the register number';
    }
    // Define your regex pattern for the register number
    final regExp = RegExp(r'^[a-zA-Z0-9]+$');
    // Check if the value matches the regex pattern
    if (!regExp.hasMatch(this)) {
      return 'Please enter a valid register number';
    }
    // If the value passes all checks, return null indicating no error
    return null;
  }

  String? validateAddress() {
    if (isEmpty) {
      return 'Please enter your address';
    }
    // Additional validation rules can be added here
    return null;
  }

  String? validatePhoneNumber() {
    if (isEmpty) {
      return 'Please enter your phone number';
    }
    // Define your regex pattern for the phone number
    final regExp = RegExp(r'^[0-9]+$');
    // Check if the value matches the regex pattern
    if (!regExp.hasMatch(this)) {
      return 'Please enter a valid phone number';
    }
    // If the value passes all checks, return null indicating no error
    return null;
  }

  String? validateWebsite() {
    if (isEmpty) {
      return 'Please enter a website';
    }
    // Additional validation rules can be added here
    return null;
  }

}


final List<TextInputFormatter> nameInputFormatter = [
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
];


extension DateTimeExtension on DateTime {
  /// extension variable to show date with time format
  /// eg: just now, 10m ago, 2h ago, 1d ago and 10-10-2022
  String get toTimeFormat {
    try {
      int differenceInMinute = DateTime.now().difference(this).inMinutes;
      int differenceInHour = DateTime.now().difference(this).inHours;
      int differenceInDay = DateTime.now().difference(this).inDays;

      if (differenceInMinute < 2) {
        return "just now";
      } else if (differenceInMinute >= 2 && differenceInMinute < 60) {
        return "${differenceInMinute}m ago";
      } else if (differenceInMinute >= 60 && differenceInMinute < 1440) {
        return "${differenceInHour}h ago";
      } else if (differenceInMinute >= 1440 && differenceInMinute < 8640) {
        return "${differenceInDay}d ago";
      } else {
        return "$day-$month-$year";
      }
    } catch (e) {
      return "$day-$month-$year";
    }
  }

  /// extension variable to show date with a simple format
  /// eg : Today, Yesterday, 10-10-2022
  String get simpleFormat {
    final now = DateTime.now();
    final nowformatted = "${now.day}/${now.month}/${now.year}";

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayformatted =
        "${yesterday.day}/${yesterday.month}/${yesterday.year}";

    final formatted = "$day/$month/$year";

    if (formatted == nowformatted) {
      return "Today";
    }

    if (formatted == yesterdayformatted) {
      return "Yesterday";
    }

    return formatted;
  }
}
