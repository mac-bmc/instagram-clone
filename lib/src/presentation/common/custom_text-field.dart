import 'package:app_clone/src/presentation/common/settings_button_blue.dart';
import 'package:app_clone/src/presentation/common/settings_button_white.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.labelText,
      required this.hintText,
      required this.onSubmit,
      required this.onModeChange,
      required this.keyBoardType, required this.submitBtnText, required this.cancelBtnText});
  final String? title ;
  final String subtitle;
  final String submitBtnText;
  final String? cancelBtnText;
  final String labelText;
  final String hintText;
  final Function onSubmit;
  final VoidCallback? onModeChange;
  final TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Column(
      children: [
        title != null ? Row(
          children: [
            Text(title.toString(),
                style: Theme.of(context).textTheme.displayLarge),
            const Spacer()
          ],
        ): Container(),
        const SizedBox(
          height: 10.0,
        ),
        Text(subtitle,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18)),
        const SizedBox(height: 20.0),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: labelText,
            hintText: hintText,
          ),
          keyboardType: TextInputType.phone,
        ),
        SettingsBtnTrue(
            callback: () {
              onSubmit(textEditingController.text.trim());
            },
            btnText: submitBtnText),
        const Spacer(),
        cancelBtnText != null && onModeChange !=null ?
        SettingsBtnFalse(
            callback: () {
              onModeChange!();
            },
            btnText: cancelBtnText.toString()):const SizedBox.shrink()
      ],
    );
  }
}
