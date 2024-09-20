import 'package:app_clone/src/application/auth/auth_bloc.dart';
import 'package:app_clone/src/presentation/common/custom_text-field.dart';
import 'package:app_clone/src/presentation/common/otp_screen.dart';
import 'package:app_clone/src/presentation/common/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String registerMode;
  late AuthBloc _authBloc;

  @override
  void initState() {
    //context.read<AuthBloc>().add(RegisterInitialEvent());
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(RegisterInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                height: double.infinity,
                child: BlocConsumer<AuthBloc, AuthState?>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(state.errorMsg)),
                        );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthOtpState) {
                      return OtpScreen(
                        isEmailOtp: state.isEmailOtp,
                        authBloc: _authBloc,
                      );
                    }
                    if (state is PasswordState) {
                      return PasswordScreen(
                          authBloc: _authBloc, isEmail: state.isEmail);
                    }
                    if (state is RegisterEmailState) {
                      return CustomTextField(
                        title: "Enter your Email Address",
                        subtitle:
                            "Enter a valid mail address.This wont be shown to other users",
                        labelText: "Email",
                        hintText: "johndoe@gmail.com",
                        onSubmit: (fieldValue) {
                          if (fieldValue.isNotEmpty &&
                              fieldValue.contains("@")) {
                            context
                                .read<AuthBloc>()
                                .add(EmailOtpEvent(authEmail: fieldValue));
                          }
                        },
                        onModeChange: () {
                          context.read<AuthBloc>().add(RegisterMobileEvent());
                        },
                        keyBoardType: TextInputType.emailAddress,
                        submitBtnText: 'Submit',
                        cancelBtnText: 'Use Phone Number instead',
                      );
                    }
                    if (state is RegisterPhoneState) {
                      return CustomTextField(
                        title: "Enter your phone number",
                        subtitle:
                            "Enter a valid phone number.This wont be shown to other users",
                        labelText: "Phone Number",
                        hintText: "+91999999999",
                        onSubmit: (fieldValue) {
                          if (fieldValue.isNotEmpty &&
                              fieldValue.length != 13) {
                            context
                                .read<AuthBloc>()
                                .add(MobileOtpEvent(authPhone: fieldValue));
                          }
                        },
                        onModeChange: () {
                          context.read<AuthBloc>().add(RegisterMailEvent());
                        },
                        keyBoardType: TextInputType.phone,
                        submitBtnText: 'Submit',
                        cancelBtnText: 'Use Email instead',
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ))));
  }
}
