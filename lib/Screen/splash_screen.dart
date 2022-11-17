import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music_app/Function/function.dart';
import 'package:music_app/Screen/animation_screen.dart';

import 'package:music_app/Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchingsongs();
    gotohome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 8, 11),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Animationpage(),
          RichText(
            text: const TextSpan(
                text: ' M  U  Z  I ',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: '● ',
                    style: TextStyle(fontSize: 15, color: Colors.redAccent),
                  ),
                  TextSpan(
                    text: 'k  O ',
                    style: TextStyle(
                        fontSize: 33,
                        color: Color.fromARGB(255, 46, 127, 127),
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Future<void> gotohome() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Homescreen(audiosongs: audiosongs),
      ),
    );
  }
}
