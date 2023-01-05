import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/pages/UploadPhoto/UploadPhoto.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loading.dart';
import 'package:tagyourtaxi_driver/pages/noInternet/nointernet.dart';
import 'package:tagyourtaxi_driver/pages/onTripPage/map_page.dart';
import 'package:tagyourtaxi_driver/pages/referralcode/referral_code.dart';
import 'package:tagyourtaxi_driver/styles/styles.dart';
import 'package:tagyourtaxi_driver/translations/translation.dart';
import 'package:tagyourtaxi_driver/widgets/widgets.dart';
import './login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

String name = ''; //name of user
String email = ''; // email of user
dynamic proImageFile1;

class _GetStartedState extends State<GetStarted> {
  bool _loading = false;
  var verifyEmailError = '';
  var _error = '';
  ImagePicker picker = ImagePicker();
  bool _pickImage = false;
  String _permission = '';

  getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }
    return status;
  }

//get camera permission
  getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.camera.request();
    }
    return status;
  }

//pick image from gallery
  pickImageFromGallery() async {
    var permission = await getGalleryPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        proImageFile1 = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noPhotos';
      });
    }
  }

//pick image from camera
  pickImageFromCamera() async {
    var permission = await getCameraPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        proImageFile1 = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noCamera';
      });
    }
  }

  //navigate
  navigate() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UploadPhoto()),
        (route) => false);
  }

  TextEditingController emailText =
      TextEditingController(); //email textediting controller
  TextEditingController nameText =
      TextEditingController(); //name textediting controller

  @override
  void initState() {
    proImageFile1 = null;
    super.initState();
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
                // padding: EdgeInsets.only(
                //     left: media.width * 0.08,
                //     right: media.width * 0.08,
                //     top: media.width * 0.05 +
                //         MediaQuery.of(context).padding.top),
                // height: media.height * 1,
                // width: media.width * 1,
                // color: page,
                child: Column(
                  children: [
                    Container(
                        //height: media.height * 0.12,
                        width: media.width * 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.arrow_back)),
                            ],
                          ),
                        )),
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
                              "User Information",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.012,
                          ),
                          Center(
                            child: Text(
                              // languages[choosenLanguage]['text_fill_form'],
                              "Upload Your Profile Picture",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontSize: 14,
                                  color: textColor.withOpacity(0.3)),
                            ),
                          ),
                          SizedBox(height: media.height * 0.04),

                          Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _pickImage = true;
                                });
                              },
                              child: proImageFile1 != null
                                  ? Container(
                                      height: media.width * 0.4,
                                      width: media.width * 0.4,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: backgroundColor,
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(proImageFile1)),
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      height: media.width * 0.4,
                                      width: media.width * 0.4,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: topBar,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/privacypolicy.png'),
                                        ),
                                      ),
                                    ),
                            ),
                          ),

                          SizedBox(height: media.height * 0.04),

                          // name input field
                          // InputField(
                          //   icon: Icons.person_outline_rounded,
                          //   text: "Name",
                          //   // languages[choosenLanguage]['text_name'],
                          //   onTap: (val) {
                          //     setState(() {
                          //       name = nameText.text;
                          //     });
                          //   },
                          //   textController: nameText,
                          // ),
                          // Name Inout
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Given Name',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Inter-Medium'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 51,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter-Medium',
                                color: Color(0xff156cf7),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Hello@Zachry.com',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: themeM1,
                                  size: 30,
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: themeM1,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.012,
                          ),
                          //Sir Name Input
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sir Name',
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium', fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 51,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter-Medium',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Hello@Zachry.com',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: themeM1,
                                  size: 30,
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: themeM1,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.012,
                          ),
                          // DateofBirth
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Date of Birth',
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium', fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 51,
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter-Medium',
                              ),
                              decoration: InputDecoration(
                                hintText: '12/16/1990',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: themeM1,
                                  size: 30,
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: themeM1,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.012,
                          ),
                          // DateofBirth
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ID Card Number',
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium', fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 51,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter-Medium',
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: '**************',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeM1),
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Color(0xfff8f7fb),
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  color: themeM1,
                                  size: 30,
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: themeM1,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          //email already exist error
                          (verifyEmailError != '')
                              ? Container(
                                  margin:
                                      EdgeInsets.only(top: media.height * 0.03),
                                  alignment: Alignment.center,
                                  width: media.width * 0.8,
                                  child: Text(
                                    verifyEmailError,
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * sixteen,
                                        color: Colors.red),
                                  ),
                                )
                              : Container(),

                          Container(
                            padding: EdgeInsets.all(media.width * 0.05),
                            child: ElevatedButton(
                              onPressed: () {
                                navigate();
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter-SemiBold',
                                  fontSize: 16,
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
                          (nameText.text.isNotEmpty &&
                                  emailText.text.isNotEmpty)
                              ? Container(
                                  width: media.width * 1,
                                  alignment: Alignment.center,
                                  child: Button(
                                    onTap: () async {
                                      String pattern =
                                          r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])*$";
                                      RegExp regex = RegExp(pattern);
                                      if (regex.hasMatch(emailText.text)) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        setState(() {
                                          verifyEmailError = '';
                                          _loading = true;
                                        });
                                        var result = await validateEmail();
                                        setState(() {
                                          _loading = false;
                                        });
                                        if (result == 'success') {
                                          setState(() {
                                            verifyEmailError = '';
                                          });
                                          navigate();
                                        } else {
                                          setState(() {
                                            verifyEmailError =
                                                result.toString();
                                          });
                                          debugPrint('failed');
                                        }
                                      } else {
                                        setState(() {
                                          verifyEmailError = "Email validated"
                                              // languages[choosenLanguage]['text_email_validation']
                                              ;
                                        });
                                      }
                                    },
                                    text: "Next",
                                  ))
                              //languages[choosenLanguage]['text_next']))
                              : Container()
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),

            (_pickImage == true)
                ? Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _pickImage = false;
                        });
                      },
                      child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 1,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                  border: Border.all(
                                    color: borderLines,
                                    width: 1.2,
                                  ),
                                  color: page),
                              child: Column(
                                children: [
                                  Container(
                                    height: media.width * 0.02,
                                    width: media.width * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          media.width * 0.01),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              pickImageFromCamera();
                                            },
                                            child: Container(
                                                height: media.width * 0.171,
                                                width: media.width * 0.171,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: borderLines,
                                                        width: 1.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: media.width * 0.064,
                                                )),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_camera'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * ten,
                                                color: const Color(0xff666666)),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              pickImageFromGallery();
                                            },
                                            child: Container(
                                                height: media.width * 0.171,
                                                width: media.width * 0.171,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: borderLines,
                                                        width: 1.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  size: media.width * 0.064,
                                                )),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_gallery'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * ten,
                                                color: const Color(0xff666666)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                : Container(),

            //permission denied popup
            (_permission != '')
                ? Positioned(
                    child: Container(
                    height: media.height * 1,
                    width: media.width * 1,
                    color: Colors.transparent.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: media.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _permission = '';
                                    _pickImage = false;
                                  });
                                },
                                child: Container(
                                  height: media.width * 0.1,
                                  width: media.width * 0.1,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: page),
                                  child: const Icon(Icons.cancel_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Container(
                          padding: EdgeInsets.all(media.width * 0.05),
                          width: media.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: page,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    color: Colors.black.withOpacity(0.2))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: media.width * 0.8,
                                  child: Text(
                                    (_permission == 'noPhotos')
                                        ? languages[choosenLanguage]
                                            ['text_open_photos_setting']
                                        : languages[choosenLanguage]
                                            ['text_open_camera_setting'],
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * sixteen,
                                        color: textColor,
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(height: media.width * 0.05),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        await openAppSettings();
                                      },
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_open_settings'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: buttonColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  InkWell(
                                      onTap: () async {
                                        (_permission == 'noCamera')
                                            ? pickImageFromCamera()
                                            : pickImageFromGallery();
                                        setState(() {
                                          _permission = '';
                                        });
                                      },
                                      child: Text(
                                        languages[choosenLanguage]['text_done'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: buttonColor,
                                            fontWeight: FontWeight.w600),
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                : Container(),

            //internet not connected
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () {
                        setState(() {
                          internetTrue();
                        });
                      },
                    ))
                : Container(),

            //loader
            (_loading == true)
                ? const Positioned(top: 0, child: Loading())
                : Container()
          ],
        ),
      ),
    );
  }
}
