import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loading.dart';
import 'package:tagyourtaxi_driver/pages/noInternet/nointernet.dart';
import 'package:tagyourtaxi_driver/pages/onTripPage/map_page.dart';
import 'package:tagyourtaxi_driver/styles/styles.dart';
import 'package:tagyourtaxi_driver/widgets/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Material(
      color: page,
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 600,
                width: 320,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: media.height * 0.04,
                          ),
                          Center(
                            child: Text(
                              // languages[choosenLanguage]['text_get_started'],
                              "Welcome Onboard",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter-SemiBold',
                                  fontSize: 24,
                                  // fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.012,
                          ),
                          Center(
                            child: Text(
                              // languages[choosenLanguage]['text_fill_form'],
                              "Swift Ride",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * sixteen,
                                  color: textColor.withOpacity(0.3)),
                            ),
                          ),
                          SizedBox(height: media.height * 0.04),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: media.width * 0.6,
                              width: media.width * 0.4,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: topBar,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/SuccessfulRegistarion.png'),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              // languages[choosenLanguage]['text_get_started'],
                              "Your registration has been successful ",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: 'Inter-SemiBold',
                                  fontSize: 24,
                                  // fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ),
                          SizedBox(height: media.height * 0.10),
                          Container(
                            padding: EdgeInsets.all(media.width * 0.05),
                            child: ElevatedButton(
                              onPressed: () {
                                navigate();
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter-SemiBold',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(55),
                                // NEW
                                primary: page,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ], //image pick
        ),
      ),
    );
  }
}
