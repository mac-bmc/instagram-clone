import 'package:app_clone/src/application/app_initial/app_initial_bloc.dart';
import 'package:app_clone/src/application/auth/auth_bloc.dart';
import 'package:app_clone/src/presentation/common/custom_text-field.dart';
import 'package:app_clone/src/presentation/common/settings_button_blue.dart';
import 'package:app_clone/src/utils/credential_validation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordScreen extends StatefulWidget {
   const PasswordScreen({super.key, required this.authBloc, required this.isEmail});
  final AuthBloc authBloc;
  final bool isEmail;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController pswdController = TextEditingController();
  late AppInitialBloc _appInitialBloc;

  @override
  void initState() {
    super.initState();
    _appInitialBloc = BlocProvider.of<AppInitialBloc>(context);
  }
  void onPasswordSubmit(context)
  {
    if(isPasswordValid(pswdController.text.trim()))
      {
        _appInitialBloc.add(AppLoadingEvent());
        widget.authBloc.add(SignUpWithEmailAndPasswordEvent(pswd: pswdController.text.trim()));
        Navigator.of(context).pop();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Create a password"),
          const SizedBox(height: 30),
          TextField(
            controller: pswdController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: "Password",
              hintText:"Hello@1234",
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
          const Spacer(),
          SettingsBtnTrue(callback:(){onPasswordSubmit(context);}, btnText: "Submit")
        ],
      ),
    );
  }
}
