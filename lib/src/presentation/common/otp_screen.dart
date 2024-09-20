import 'package:app_clone/src/application/auth/auth_bloc.dart';
import 'package:app_clone/src/presentation/common/otp_text_field.dart';
import 'package:app_clone/src/presentation/common/settings_button_blue.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.isEmailOtp, required this.authBloc});

  final bool isEmailOtp;
  final AuthBloc authBloc;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  void onSubmitCallback()
  {
    final String otp = _fieldOne.text.trim()+_fieldTwo.text.trim()+_fieldThree.text.trim()+_fieldFour.text.trim();
    if(isEmailOtp)
      {
        authBloc.add(OtpValidationEvent(otp: otp,isEmailOtp));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Enter Otp"),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpTextField(textEditingController: _fieldOne, autoFocus: true),
              OtpTextField(textEditingController: _fieldTwo, autoFocus: false),
              OtpTextField(
                  textEditingController: _fieldThree, autoFocus: false),
              OtpTextField(textEditingController: _fieldFour, autoFocus: false),
            ],
          ),
          const Spacer(),
          SettingsBtnTrue(callback: onSubmitCallback, btnText: "Submit")
        ],
      ),
    );
  }
}
