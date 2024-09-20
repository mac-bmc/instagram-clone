part of 'auth_bloc.dart';

@immutable
final class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class RegisterEmailState extends AuthState {}

final class RegisterPhoneState extends AuthState {}

final class PasswordState extends AuthState {
  final bool isEmail;

  PasswordState({required this.isEmail});
}

final class ErrorState extends AuthState {
  final String errorMsg;

  ErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class AuthResultWaitingState extends AuthState {}

final class AuthOtpState extends AuthState{

  final bool isEmailOtp;

  AuthOtpState({required this.isEmailOtp});
  @override
  List<Object?> get props => [isEmailOtp];
}