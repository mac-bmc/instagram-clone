import 'package:flutter/material.dart';

class SettingsBtnTrue extends StatelessWidget {
  const SettingsBtnTrue({super.key, required this.callback,required this.btnText});

  final Function callback;
  final String btnText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){callback();},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(child: Text(btnText,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white))),
      ),
    );
  }
}
