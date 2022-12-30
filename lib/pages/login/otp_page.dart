import 'package:flutter/material.dart';
import 'package:tagyourtaxi_driver/pages/onTripPage/booking_confirmation.dart';
import 'package:tagyourtaxi_driver/pages/onTripPage/invoice.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loading.dart';
import 'package:tagyourtaxi_driver/pages/login/get_started.dart';
import 'package:tagyourtaxi_driver/pages/login/login.dart';
import 'package:tagyourtaxi_driver/pages/onTripPage/map_page.dart';
import 'package:tagyourtaxi_driver/pages/noInternet/nointernet.dart';
import 'package:tagyourtaxi_driver/translations/translation.dart';
import 'package:tagyourtaxi_driver/widgets/widgets.dart';
import '../../styles/styles.dart';
import '../../functions/functions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otpNumber = ''; //otp number
  List otpText = []; //otp number as list for 6 boxes
  List otpPattern = [1, 2, 3, 4, 5, 6]; //list to create number of input box
  var resendTime = 60; //otp resend time
  late Timer timer; //timer for resend time
  String _error =
      ''; //otp error string to show if error occurs in otp validation
  TextEditingController otpController =
      TextEditingController(); //otp textediting controller
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  TextEditingController fifth = TextEditingController();
  TextEditingController sixth = TextEditingController();
  bool _loading = false; //loading screen showing
  @override
  void initState() {
    _loading = false;
    timers();
    otpFalse();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel;
    super.dispose();
  }

  //navigate
  navigate(verify) {
    // if (verify == true) {
    //   if (userRequestData.isNotEmpty && userRequestData['is_completed'] == 1) {
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => const Invoice()),
    //         (route) => false);
    //   } else if (userRequestData.isNotEmpty &&
    //       userRequestData['is_completed'] != 1) {
    //     Future.delayed(const Duration(seconds: 2), () {
    //       if (userRequestData['is_rental'] == true) {
    //         Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => BookingConfirmation(
    //                       type: 1,
    //                     )),
    //             (route) => false);
    //       } else {
    //         Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(builder: (context) => BookingConfirmation()),
    //             (route) => false);
    //       }
    //     });
    //   } else {
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => const Maps()),
    //         (route) => false);
    //   }
    // }  else if(verify == false) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const GetStarted()));
    // } else {
    //   _error = verify.toString();
    //   setState(() {
    //     _loading = false;
    //   });
    // }
  }

  //otp is false
  otpFalse() async {
    if (phoneAuthCheck == false) {
      _loading = true;
      otpController.text = '123456';
      otpNumber = otpController.text;
      var verify = await verifyUser(phnumber);

      navigate(verify);
    }
  }

  //auto verify otp

  verifyOtp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credentials);

      var verify = await verifyUser(phnumber);
      navigate(verify);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-verification-code') {
        setState(() {
          otpController.clear();
          otpNumber = '';
          _error = languages[choosenLanguage]['text_otp_error'];
        });
      }
    }
  }

// running resend otp timer
  timers() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime != 0) {
        if (mounted) {
          setState(() {
            resendTime--;
          });
        }
      } else {
        timer.cancel();
      }
    });
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
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              if (credentials != null) {
                _loading = true;
                verifyOtp();
              }
              return Stack(
                children: [
                  Center(
                    child: Container(
                      // padding: EdgeInsets.only(
                      //     left: media.width * 0.08,
                      //     right: media.width * 0.08,
                      //     top: media.width * 0.05 +
                      //         MediaQuery.of(context).padding.top),
                      // color: topBar,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      height: 600,
                      width: 320,
                      child: Column(
                        children: [
                          SizedBox(
                            height: media.height * 0.04,
                          ),
                          Container(
                              color: topBar,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.arrow_back)),
                                ],
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: media.height * 0.02,
                                ),
                                SizedBox(
                                  width: media.width * 1,
                                  child: Center(
                                    child: Text(
                                      // languages[choosenLanguage]['text_phone_verify'],
                                      "Enter your passcode",
                                      style: GoogleFonts.roboto(
                                          fontSize: media.width * twentyfour,
                                          fontWeight: FontWeight.bold,
                                          color: textColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  // languages[choosenLanguage]['text_enter_otp'],
                                  "We’ve sent the code to the email on your device",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      color: textColor.withOpacity(0.3)),
                                ),
                                const SizedBox(height: 10),
                                Center(child: Image.asset('assets/images/enterotp.png')),
                                SizedBox(height: media.height * 0.04),
                                Container(
                                  height: 55,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _textFieldOTP(first: true, last: false),
                                      _textFieldOTP(first: false, last: false),
                                      _textFieldOTP(first: false, last: false),
                                      _textFieldOTP(first: false, last: true),
                                    ],
                                  ),
                                  // height: media.width * 0.15,
                                  // width: media.width * 0.9,
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(12),
                                  //     color: page,
                                  //     border: Border.all(
                                  //         color: borderLines, width: 1.2)),
                                  // child: TextField(
                                  //   controller: otpController,
                                  //   autofocus:
                                  //       (phoneAuthCheck == false) ? false : true,
                                  //   onChanged: (val) {
                                  //     setState(() {
                                  //       otpNumber = val;
                                  //     });
                                  //     if (val.length == 6) {
                                  //       FocusManager.instance.primaryFocus
                                  //           ?.unfocus();
                                  //     }
                                  //   },
                                  //   decoration: InputDecoration(
                                  //     border: InputBorder.none,
                                  //     counterText: '',
                                  //     hintText:
                                  //         "Please enter the 6-digit code send to you at",
                                  //   ),
                                  //   // languages[choosenLanguage]['text_enter_otp_login']),
                                  //   textAlign: TextAlign.center,
                                  //   style: GoogleFonts.roboto(
                                  //     fontSize: media.width * twenty,
                                  //     color: textColor,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  //   maxLength: 6,
                                  //   keyboardType: TextInputType.number,
                                  // ),
                                ),
                                SizedBox(height: media.height * 0.02),
                                Container(
                                  height: 13,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Code expires in : ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text('00 : 56 ',
                                        style: TextStyle(fontSize: 12,color: themeM1),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: media.height * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Didn’t receive code?',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(' Resend Code',
                                      style: TextStyle(fontSize: 12,color: themeM1),
                                    ),
                                  ],
                                ),

                                // show error on otp
                                (_error != '')
                                    ? Container(
                                  width: media.width * 0.8,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: media.height * 0.02),
                                  child: Text(
                                    _error,
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * sixteen,
                                        color: Colors.red),
                                  ),
                                )
                                    : Container(),

                                //Button
                                Container(
                                  padding: EdgeInsets.all(media.width * 0.04),
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => const GetStarted()));
                                      // if (otpNumber.length == 6) {
                                      //   timer.cancel();
                                      //   setState(() {
                                      //     _loading = true;
                                      //     _error = '';
                                      //   });
                                      //   //firebase code send false
                                      //   if (phoneAuthCheck == false) {
                                      //     var verify = await verifyUser(phnumber);
                                      //
                                      //     navigate(verify);
                                      //   } else {
                                      //     // firebase code send true
                                      //     try {
                                      //       PhoneAuthCredential credential =
                                      //           PhoneAuthProvider.credential(
                                      //               verificationId: verId,
                                      //               smsCode: otpNumber);
                                      //
                                      //       // Sign the user in (or link) with the credential
                                      //       await FirebaseAuth.instance
                                      //           .signInWithCredential(credential);
                                      //
                                      //       var verify =
                                      //           await verifyUser(phnumber);
                                      //       navigate(verify);
                                      //     } on FirebaseAuthException catch (error) {
                                      //       if (error.code ==
                                      //           'invalid-verification-code') {
                                      //         setState(() {
                                      //           otpController.clear();
                                      //           otpNumber = '';
                                      //           _error =
                                      //               languages[choosenLanguage]
                                      //                   ['text_otp_error'];
                                      //           _loading = false;
                                      //         });
                                      //       }
                                      //     }
                                      //   }
                                      // } else if (phoneAuthCheck == true &&
                                      //     resendTime == 0 &&
                                      //     otpNumber.length != 6) {
                                      //   setState(() {
                                      //     setState(() {
                                      //       resendTime = 60;
                                      //     });
                                      //     timers();
                                      //   });
                                      //   phoneAuth(countries[phcode]['dial_code'] + phnumber);
                                      // }
                                    },
                                    // borcolor:
                                    //     (resendTime != 0 && otpNumber.length != 6)
                                    //         ? underline
                                    //         : null,
                                    // text: (otpNumber.length == 6)
                                    //     ? "Verify Now"
                                    // //languages[choosenLanguage]['text_verify']
                                    //     : (resendTime == 0)
                                    // ?"Resend Code"
                                    // :"Resend Code "+resendTime.toString(),
                                    //? languages[choosenLanguage]['text_resend_code']
                                    //: languages[choosenLanguage]
                                    // ['text_resend_code'] +
                                    //' ' +
                                    //resendTime.toString(),
                                    // color:
                                    //     (resendTime != 0 && otpNumber.length != 6)
                                    //         ? underline
                                    //         : null,
                                    child:  Text(
                                      'Verify Code',
                                      style: TextStyle(color: Colors.white,fontSize: 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(55), // NEW
                                      primary: page,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //no internet
                  (internet == false)
                      ? Positioned(
                          top: 0,
                          child: NoInternet(onTap: () {
                            setState(() {
                              internetTrue();
                            });
                          }))
                      : Container(),

                  //loader
                  // (_loading == true)
                  //     ? Positioned(
                  //         top: 0,
                  //         child: SizedBox(
                  //           height: media.height * 1,
                  //           width: media.width * 1,
                  //           child: const Loading(),
                  //         ))
                  //     : Container()
                ],
              );
            }),
      ),
    );
  }
  Widget _textFieldOTP({required bool first, required bool last}) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style:  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: themeM1),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
