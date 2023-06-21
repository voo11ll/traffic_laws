import 'package:action_slider/action_slider.dart';
import 'package:traffic/page/ticketspage.dart';
import 'package:traffic/pages/exercise/exercise.dart';
import 'package:traffic/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../page/page.dart';

class joinNow extends StatefulWidget {
  const joinNow({Key? key}) : super(key: key);

  @override
  State<joinNow> createState() => _joinNowState();
}

class _joinNowState extends State<joinNow> {
  final _controller = ActionSliderController();

  get kItemSelectBottomNav => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/images/s6.png",
            // color: Colors.green,
          ),
        Text(
        "Начало прохождения",
        style: GoogleFonts.aclonica(
          textStyle: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
      ),
      ActionSlider.standard(
        sliderBehavior: SliderBehavior.stretch,
        width: 300.0.w,
        child: Text(
          'Экзамен',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        toggleColor: Colors.lightGreenAccent,
        action: (controller) async {
          controller.loading(); // starts loading animation
          await Future.delayed(const Duration(seconds: 3), () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => Home(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(seconds: 1),
              ),
            );
          });
          controller.success(); // starts success animation
          await Future.delayed(const Duration(seconds: 1));
          controller.reset(); // resets the slider
        },
      ),
      ActionSlider.standard(
        sliderBehavior: SliderBehavior.stretch,
        width: 300.0.w,
        child: Text(
          'Билеты АВ',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        toggleColor: Colors.lightBlueAccent,
        action: (controller) async {
          controller.loading(); // starts loading animation
          await Future.delayed(const Duration(seconds: 3), () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => TicketsPage(), // Замените на нужную страницу
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(seconds: 1),
              ),
            );
          });
          controller.success(); // starts success animation
          await Future.delayed(const Duration(seconds: 1));
          controller.reset(); // resets the slider
        },
      ),
          ActionSlider.standard(
            sliderBehavior: SliderBehavior.stretch,
            width: 300.0.w,
            child: Text(
              'Темы',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            toggleColor: Colors.lightBlueAccent,
            action: (controller) async {
              controller.loading(); // starts loading animation
              await Future.delayed(const Duration(seconds: 3), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => PDDHomePage(), // Замените на нужную страницу
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(seconds: 1),
                  ),
                );
              });
              controller.success(); // starts success animation
              await Future.delayed(const Duration(seconds: 1));
              controller.reset(); // resets the slider
            },
          ),

        ],
      ),
    );
  }
}
