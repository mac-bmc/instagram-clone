import 'dart:math';

class OtpGeneratorUtil
{
  static String otp="";

  static generateOTP() {
    final random = Random();
    const digits = '0123456789';
    otp = List.generate(5, (index) => digits[random.nextInt(digits.length)]).join();
  }

}