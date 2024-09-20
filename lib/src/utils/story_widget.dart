import 'package:app_clone/src/presentation/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});
//accept image Url
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 60,
      width: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(
            width: 1,
            color: AppColors.storyBg
          )
        ),
        child:SvgPicture.asset('assets/instagram-1-svgrepo-com.svg')
      ),
    );
  }
}
