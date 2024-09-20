import 'package:flutter/material.dart';

class SettingsBtnFalse extends StatelessWidget {
  const SettingsBtnFalse({super.key, required this.callback,required this.btnText});

  final Function callback;
  final String btnText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        debugPrint("click");
        callback();},
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                color: Colors.blue
            )
        ),
        child: Center(child: Text(btnText,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.blue))),
      ),
    );
  }
}
