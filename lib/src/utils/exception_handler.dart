import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String handleFirebaseAuthException(FirebaseAuthException e) {
  debugPrint("EXCEPTION_CODE${e.code}");
  switch (e.code) {
    case 'invalid-user':
      return 'The user account does not exist or has been disabled.';
    case 'invalid-credential':
      return 'The credentials provided are incorrect or invalid.';

    case 'user-collision':
      return 'An account already exists with the provided email or phone number.';
    case 'weak-password':
      return 'The password provided is not strong enough.';
    case 'invalid-email':
      return 'The email address provided is not valid.';
    case 'recent-login-required':
      return 'A sensitive operation requires the user to have recently logged in.';
    case 'multi-factor-required':
      return 'Multi-factor authentication is required to complete the sign-in process.';
    default:
      return 'An undefined Error happened.';
  }
}
