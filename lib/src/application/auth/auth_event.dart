part of 'auth_bloc.dart';

@immutable
final class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AppStartedEvent extends AuthEvent {}

final class RegisterInitialEvent extends AuthEvent {}

final class RegisterEvent extends AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String userId;
  final String pswd;

  LoginEvent({required this.userId, required this.pswd});
}

final class GoogleAuthEvent extends AuthEvent {}

final class EmailOtpEvent extends AuthEvent {
  final String authEmail;

  EmailOtpEvent({required this.authEmail});
}

final class MobileOtpEvent extends AuthEvent {
  final String authPhone;

  MobileOtpEvent({required this.authPhone});
}

final class RegisterMailEvent extends AuthEvent {}

final class RegisterMobileEvent extends AuthEvent {}

final class OtpValidationEvent extends AuthEvent {
  final String otp;
  final bool isEmailOtp;

  OtpValidationEvent(this.isEmailOtp, {required this.otp});
}

final class SignUpWithEmailAndPasswordEvent extends AuthEvent {
  final String pswd;

  SignUpWithEmailAndPasswordEvent({required this.pswd});
}
