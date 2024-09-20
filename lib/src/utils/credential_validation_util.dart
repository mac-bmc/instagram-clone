import 'package:flutter/material.dart';

bool isEmailValid(String email) {
// Regular expression for validating an email address
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

// Check if the email matches the regular expression
  return emailRegex.hasMatch(email);
}

bool isPasswordValid(String password) {
// Regular expression for validating a password
  /*^(?=.*[A-Za-z]): Ensures the password contains at least one letter.

  •  (?=.*\d): Ensures the password contains at least one digit.

  •  [A-Za-z\d]{8,}$: Ensures the password is at least 8 characters long and contains only letters and digits.*/

  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

// Check if the password matches the regular expression
  debugPrint("passwordMatch:${passwordRegex.hasMatch(password)}");
  return passwordRegex.hasMatch(password);
}

bool isPhoneNumberValid(String phoneNumber) {
// Regular expression for validating a phone number
/* ^\+?: Ensures the phone number can optionally start with a + sign.

•  [1-9]: Ensures the phone number starts with a digit between 1 and 9.

•  \d{1,14}$: Ensures the phone number has between 1 and 14 digits following the initial digit.*/

  final RegExp phoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );

// Check if the phone number matches the regular expression
  return phoneRegex.hasMatch(phoneNumber);
}

bool ifEmail(String value) {
  switch (isEmailValid(value)) {
    case true:
      {
        return true;
      }
    case false:
      {
        return false;
      }
  }
}
