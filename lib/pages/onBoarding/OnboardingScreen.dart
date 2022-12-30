import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loadingpage.dart';
import 'package:tagyourtaxi_driver/pages/login/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white);
    const pageDecoration =  PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      // bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xFF369CC7),
      imagePadding: EdgeInsets.zero,
      fullScreen: false,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color(0xFF369CC7),
      pages: [
        PageViewModel(
          title: "Request Ride",
          body:
          "Request a ride get picked up by a nearby community driver'",
          image: _buildImage('onboarding0.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Confirm Your Driver',
          body:
          "Huge drivers network helps you find comfortable and cheap ride",
          image: _buildImage('onboarding1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Track Your Ride",
          body:
          "Know your driver in advance and be able to view current location in real time on the map",
          image: _buildImage('onboarding2.png'),
          footer: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text(
                'GET STARTED',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55), // NEW
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],

      showSkipButton: false,
      showDoneButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      // controlsMargin: const EdgeInsets.all(16),
      // controlsPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(8.0, 8.0),
        color: Color(0xFF369CC7),
        activeSize: Size(15.0, 5.0),
        activeColor: Color(0xFFFFFFFF),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}