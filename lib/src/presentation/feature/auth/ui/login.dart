import 'package:app_clone/src/application/auth/auth_bloc.dart';
import 'package:app_clone/src/core/routes.dart';
import 'package:app_clone/src/presentation/common/settings_button_blue.dart';
import 'package:app_clone/src/presentation/common/settings_button_white.dart';
import 'package:app_clone/src/utils/credential_validation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

class AuthFlow extends StatefulWidget {
  const AuthFlow({super.key});

  @override
  State<AuthFlow> createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final userFieldController = TextEditingController();
    return Scaffold(
      body: SafeArea(
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
        buildWhen: (previous, current) {
          debugPrint("previousState${previous}__CurrentState${current}");
          return true;
        },
        builder: (BuildContext context, AuthState? state) {
         /* if (state is AuthResultWaitingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }*/
          return _loginForm(
              context, userFieldController, passwordController, _authBloc);
        },
      )),
    );
  }
}

Widget _loginForm(
    BuildContext context,
    TextEditingController userFieldController,
    TextEditingController passwordController,
    AuthBloc authBloc) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: MediaQuery.of(context).platformBrightness == Brightness.light
          ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.gradientTop,
                Colors.white54,
              ],
              stops: [0.01, 0.2],
            )
          : null,
    ),
    child: Column(
      children: [
        Text("English[India]", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        //Insert Svg logo
        const SizedBox(height: 200),
        TextField(
          controller: userFieldController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: 'Enter your Email or Mobile Number',
            hintText: 'Name',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: 'Password',
            hintText: 'Password',
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
        SettingsBtnTrue(
            callback: () {
              if (isPasswordValid(passwordController.text.trim())) {
                if (isEmailValid(userFieldController.text.trim()) ||
                    isPhoneNumberValid(userFieldController.text.trim())) {
                  authBloc.add(LoginEvent(
                      userId: userFieldController.text.trim(),
                      pswd: passwordController.text.trim()));
                }
              }
              authBloc.add(LoginEvent(userId:userFieldController.text.trim(), pswd:passwordController.text.trim()));
            },
            btnText: "Login"),
        const SizedBox(height: 10),
        Text(
          "Forgotten Password",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.blue),
        ),
        const Spacer(),
        Center(
          child: InkWell(
            onTap: () {
              authBloc.add(GoogleAuthEvent());
            },
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                const Text("or use"),
                const SizedBox(width: 20),
                SvgPicture.asset(
                    'assets/google-svgrepo-com.svg',
                    semanticsLabel: 'SVG Image',
                    width: 50,
                    height: 50,
                  ),
              ],
            ),
          ),
        ),
        SettingsBtnFalse(
            callback: () {
              Navigator.pushNamed(context,AppRouter.REGISTER);
            },
            btnText: "Create an account")
      ],
    ),
  );
}
