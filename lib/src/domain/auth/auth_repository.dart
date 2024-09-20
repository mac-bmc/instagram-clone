import 'dart:async';

import 'package:app_clone/src/core/app_constant.dart';
import 'package:app_clone/src/domain/remoteconfig/remote_config_repository.dart';
import 'package:app_clone/src/utils/email_Otp_Util.dart';
import 'package:app_clone/src/utils/email_validation_util.dart';
import 'package:app_clone/src/utils/otp_generator_util.dart';
import 'package:dio/dio.dart.';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  static AuthRepository? instance;
  final RemoteConfigRepository _remoteConfigRepository;
  final FirebaseAuth _firebaseAuthInstance;
  final GoogleSignIn _googleSignIn;

  AuthRepository(this._remoteConfigRepository,
      {required GoogleSignIn googleInstance,
      required FirebaseAuth firebaseAuthInstance})
      : _firebaseAuthInstance = firebaseAuthInstance ?? FirebaseAuth.instance,
        _googleSignIn = googleInstance ?? GoogleSignIn();

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuthInstance.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return Future.value(_firebaseAuthInstance.currentUser);
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      await _firebaseAuthInstance.signInWithCredential(credential);
      return Future.value(_firebaseAuthInstance.currentUser);
    } catch (e) {
      debugPrint("GoogleSignInRepo${e}");
      return null;
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,}) async {
    await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    var currentUser = _firebaseAuthInstance.currentUser;
    if(currentUser ==null) {
      throw Exception("Registration Unsuccessful");
    }


    //update info
    //await currentUser!.updateDisplayName(displayName);
  }

  Future<void> phoneAuthentication(String phNumber) async {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuthInstance.signInWithCredential(credential).then(
                (value) => print('Logged In Successfully'),
              );
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("FirebaseAuthException ${e}");
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
  }

  Future<void> sendEmailOtp(String email) async
  {
    await initialiseEmailOTP();
    if(!await sendOtp(email))
    {
      throw Exception(" Sending Otp Failed");
    }

  }

  Future<void> validateEmail(String otp) async
  {
    if(!verifyOtp(otp))
      {
        if(isOtpExpired(otp))
        {
          throw Exception("Otp Expired");
        }
        else
          {
            throw Exception("Otp validation failed");
          }
      }


  }

  /*Future<void> validateEmail(String email) async {
    await OtpGeneratorUtil.generateOTP();
    await NetworkClient.dioInstance.post(
      await _remoteConfigRepository.getConfigValue('x_rapidapi_url'),
      data: getNetworkBody(email,OtpGeneratorUtil.otp),
      options: Options(
        headers: {
          'x-rapidapi-key':
              await _remoteConfigRepository.getConfigValue('x_rapidapi_key'),
          'x-rapidapi-host':
              await _remoteConfigRepository.getConfigValue('x_rapidapi_host'),
          'Content-Type': 'application/json',
        },
      ),
    );
  }*/
}
