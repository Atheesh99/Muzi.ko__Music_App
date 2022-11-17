import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Animationpage extends StatefulWidget {
  const Animationpage({super.key});

  @override
  State<Animationpage> createState() => _AnimationpageState();
}

class _AnimationpageState extends State<Animationpage>
    with SingleTickerProviderStateMixin {
  late AnimationController animcontroller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final curvedAnimation = CurvedAnimation(
        parent: animcontroller,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut);

    animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animcontroller.reverse();
            } else {
              if (status == AnimationStatus.dismissed) {
                animcontroller.forward();
              }
            }
          });

    animcontroller.fling();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: animcontroller.value,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Image.asset(
            'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
            width: 250,
            height: 200,
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animcontroller.dispose();
    super.dispose();
  }
}
