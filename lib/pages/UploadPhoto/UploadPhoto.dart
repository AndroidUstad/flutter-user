import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/pages/WelcomeScreen/WelcomeScreen.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loading.dart';
import 'package:tagyourtaxi_driver/pages/noInternet/nointernet.dart';
import 'package:tagyourtaxi_driver/styles/styles.dart';
import 'package:tagyourtaxi_driver/widgets/widgets.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}


String name = ''; //name of user
String email = ''; // email of user
dynamic proImageFile1;

class _UploadPhotoState extends State<UploadPhoto> {
  bool _loading = false;
  var verifyEmailError = '';
  TextEditingController emailText =
  TextEditingController(); //email textediting controller
  TextEditingController nameText =
  TextEditingController(); //name textediting controller

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
  }


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
                                  "Photo Upload",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twentyeight,
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
                                  "You can select image from gallery or take a "
                                      "selfie by choosing the bellow menu",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color: textColor.withOpacity(0.3)),
                                ),
                              ),
                              SizedBox(height: media.height * 0.04),

                              Center(
                                child: InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   _pickImage = true;
                                    // }
                                    // );
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
                                      image: const DecorationImage(
                                        image:  AssetImage(
                                            'assets/images/Selfie-pana.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: media.height * 0.22),

                              Container(
                                padding: EdgeInsets.all(media.width * 0.05),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _pickImage = true;
                                      if(proImageFile1!=null){
                                        navigate();
                                      }
                                    }
                                    );
                                  },
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(color: Colors.white),
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

            //image pick

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
                                  color: Colors.white,
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
                                              color: Colors.white,
                                              size: media.width * 0.064,
                                            )),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.01,
                                      ),
                                      Text(
                                        // languages[choosenLanguage]['text_camera'],
                                        "Camera",
                                        style: GoogleFonts.roboto(
                                          fontSize: media.width * ten,
                                          color: Colors.white,
                                        ),
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
                                              color: Colors.white,
                                              size: media.width * 0.064,
                                            )),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.01,
                                      ),
                                      Text(
                                        //languages[choosenLanguage]['text_gallery'],
                                        "Gallery",
                                        style: GoogleFonts.roboto(
                                          fontSize: media.width * ten,
                                          color: Colors.white,
                                        ),
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
                                  // ? languages[choosenLanguage]['text_open_photos_setting']
                                  // : languages[choosenLanguage]['text_open_camera_setting'],
                                      ? "Photos access is needed to pick image, please enable it in settings and tap done"
                                      : "Photos access is needed to pick image, please enable it in settings and tap done",
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
                                      // languages[choosenLanguage]['text_open_settings'],
                                      "Open Settings",
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
                                      // languages[choosenLanguage]['text_done'],
                                      "Done",
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
