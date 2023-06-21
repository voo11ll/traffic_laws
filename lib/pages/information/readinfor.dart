import 'dart:async';

import 'package:action_slider/action_slider.dart';
import 'package:traffic/pages/information/tipsawarness.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReadInfo extends StatefulWidget {
  const ReadInfo({Key? key}) : super(key: key);

  @override
  State<ReadInfo> createState() => _ReadInfoState();
}

class _ReadInfoState extends State<ReadInfo> {
  @override
  final AudioPlayer _player = AudioPlayer();
  runVoice() async {
    await _player.setAsset("assets/images/crash.mp3");
    await _player.play();
  }

  // Timer? timer;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   super.initState();
  //   runVoice();
  //   timer = Timer.periodic(Duration(seconds: 4), (Timer t) => runVoice());
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TipsAwarness()));
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 50,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Lottie.asset("assets/images/accidentfile.json"),
            Text(
              "ИНФОРМАЦИЯ",
              style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Правила дорожного движения - нормативный правовой документ, который регулирует на территории Российской Федерации поведение на проезжих частях всех участников дорожного движения. ( водителей, пассажиров, пешеходов и т.д.) Без знаний правил дорожного движения ученик автошкол не пройдет первый этап экзамена, поэтому знать их обязательно. Правила дорожного движения, деляться на 24-е раздела и 2 приложения.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17.sp),
            ),
            SizedBox(
              height: 100.h,
            ),
            // TextButton(
            //     onPressed: () async {
            //       await _player.setAsset("assets/images/crash.mp3");
            //       await _player.play();
            //        },
            //     child: Text("CLICK")),
            ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              width: 300.w,
              child: Text(
                'Дальше',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              toggleColor: Colors.lightGreenAccent,
              action: (controller) async {
                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(seconds: 3), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TipsAwarness()));
                });
                controller.success(); //starts success animation
                await Future.delayed(const Duration(seconds: 1));
                controller.reset(); //resets the slider
              },
            )
          ],
        ),
      ),
    );
  }
}
