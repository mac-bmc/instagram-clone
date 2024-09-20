import 'package:email_otp/email_otp.dart';

Future<void> initialiseEmailOTP() async {
  await EmailOTP.config(
    appName: "AppName",
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v1,
    otpLength: 4
  );
}

Future<bool> sendOtp(String email) async {
  return await EmailOTP.sendOTP(email: email);
}

bool verifyOtp(String otp) {
  return EmailOTP.verifyOTP(otp: otp);
}

bool isOtpExpired(String otp) {
  return EmailOTP.isOtpExpired();
}

Future<String> getOtp() async
{
  String? otp = await EmailOTP.getOTP();
  if(otp!=null) {
    return otp;
  } else {
    throw Exception("Failed to get Otp");
  }
}