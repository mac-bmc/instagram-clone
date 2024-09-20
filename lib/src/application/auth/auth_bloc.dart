import 'package:app_clone/src/application/app_initial/app_initial_bloc.dart';
import 'package:app_clone/src/domain/auth/auth_repository.dart';
import 'package:app_clone/src/utils/credential_validation_util.dart';
import 'package:app_clone/src/utils/exception_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState?> {
  final AuthRepository _authRepository;
  final AppInitialBloc _appInitialBloc;
  late String email;

  AuthBloc(this._authRepository, this._appInitialBloc) : super(null) {
    on<RegisterInitialEvent>((event, emit) {
      emit(RegisterEmailState());
    });
    on<RegisterMailEvent>((event, emit) {
      emit(RegisterEmailState());
    });
    on<RegisterMobileEvent>((event, emit) {
      emit(RegisterPhoneState());
    });
    on<EmailOtpEvent>((event, emit) async {
      emit(AuthResultWaitingState());
      await _sendEmailOtp(event, emit);
    });
    on<GoogleAuthEvent>((event, emit) async {
      emit(AuthResultWaitingState());
      await _googleAuthLogin(event, emit);
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthResultWaitingState());
      await _authLogin(event, emit);
      Future.delayed(Duration(seconds: 3));
    });
    on<MobileOtpEvent>((event, emit) async {
      await _mobileOtp(event, emit);
    });
    on<OtpValidationEvent>((event, emit) async {
      emit(AuthResultWaitingState());
      await _validateOtp(event, emit);
    });
    on<SignUpWithEmailAndPasswordEvent>((event, emit) async {
      emit(AuthResultWaitingState());
      await _signUpWithEmailAndPassword(event, emit);
    });
  }

  Future<void> _authCheck(Emitter<AuthState?> emit) async {
    _appInitialBloc.add(AuthStartedEvent() as AppInitialEvent);
  }

  Future<void> _authLogin(LoginEvent event, Emitter<AuthState?> emit) async {
    if (ifEmail(event.userId)) {
      try {
        await _authRepository.signInWithCredentials(event.userId, event.pswd);
        // Call _authCheck but don't re-emit any state here
        await _authCheck(emit);
      } on FirebaseAuthException catch (e) {
        emit(ErrorState(errorMsg: handleFirebaseAuthException(e)));
      } catch (e) {
        debugPrint("_authLoginException-${e}");
      }
    } else {
      emit(ErrorState(errorMsg: "Enter valid credentials"));
    }
  }

  Future<void> _googleAuthLogin(
      GoogleAuthEvent event, Emitter<AuthState?> emit) async {
    try {
      await _authRepository.signInWithGoogle();
      await _authCheck(emit);
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(errorMsg: handleFirebaseAuthException(e)));
    } catch (e) {
      debugPrint("_googleAuthException:${e}");
    }
  }

  Future<void> _mobileOtp(
      MobileOtpEvent event, Emitter<AuthState?> emit) async {}

  Future<void> _sendEmailOtp(
      EmailOtpEvent event, Emitter<AuthState?> emit) async {
    try {
      await _authRepository.sendEmailOtp(event.authEmail);
      email = event.authEmail;
      emit(AuthOtpState(isEmailOtp: true));
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _validateOtp(
      OtpValidationEvent event, Emitter<AuthState?> emit) async {
    try {
      if (event.isEmailOtp) {
        await _authRepository.validateEmail(event.otp);
        emit(PasswordState(isEmail: true));
      }
    } catch (e) {
      email = "";
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _signUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event, Emitter<AuthState?> emit) async {
    try {
      await _authRepository.signUp(email: email, password: event.pswd);
      _authCheck(emit);
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }
}
