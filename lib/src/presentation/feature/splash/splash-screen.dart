import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: SvgPicture.asset(
            'assets/instagram-1-svgrepo-com.svg',
            semanticsLabel: 'SVG Image',
            width: 150,
            height: 150,
          ),
        )
      ),
    );
  }
}
