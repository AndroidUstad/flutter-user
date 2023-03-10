import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loading.dart';
import 'package:tagyourtaxi_driver/pages/loadingPage/loadingpage.dart';
import 'package:tagyourtaxi_driver/pages/noInternet/nointernet.dart';
import 'package:tagyourtaxi_driver/styles/styles.dart';
import 'package:tagyourtaxi_driver/translations/translation.dart';
import 'package:tagyourtaxi_driver/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  bool _isLoading = true;
  bool _showToast = false;

  @override
  void initState() {
    _getReferral();
    super.initState();
  }

//get referral code
  _getReferral() async {
    await getReferral();
    setState(() {
      _isLoading = false;
    });
  }

//show toast for copied
  showToast() {
    setState(() {
      _showToast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showToast = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child) {
            return Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(media.width * 0.05),
                      height: media.height * 1,
                      width: media.width * 1,
                      color: white,
                      // child: (myReferralCode.isNotEmpty)
                      //     ?
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).padding.top),
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: media.width * 0.05),
                                      width: media.width * 1,
                                      alignment: Alignment.center,
                                      child: Text(
                                        // languages[choosenLanguage]['text_enable_referal'],
                                        'Referal',
                                        style: TextStyle(
                                          fontFamily: 'Inter-Regular',
                                          fontSize: 17,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child:
                                                const Icon(Icons.arrow_back)))
                                  ],
                                ),
                                SizedBox(
                                  height: media.width * 0.05,
                                ),
                                SizedBox(
                                  width: 220,
                                  height: 230,
                                  child: Image.asset(
                                    'assets/images/Invite.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  height: media.width * 0.1,
                                ),
                                // Text(
                                //   // myReferralCode['referral_comission_string'],
                                //   '1234555',
                                //   textAlign: TextAlign.center,
                                //   style: GoogleFonts.roboto(
                                //       fontSize: media.width * sixteen,
                                //       color: textColor,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                SizedBox(
                                  height: media.width * 0.05,
                                ),
                                Container(
                                    width: media.width * 0.9,
                                    padding: EdgeInsets.all(media.width * 0.05),
                                    decoration: BoxDecoration(
                                        color: backgroundColor2,
                                        border: Border.all(
                                            color: borderLines, width: 1.2),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // myReferralCode['refferal_code'],
                                              'Code',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 10,
                                                  color: textColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: media.width * 0.02,
                                            ),
                                            Text(
                                              // myReferralCode['refferal_code'],
                                              'HKG HGJF JGKF KHN',
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * sixteen,
                                                  color: textColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                Clipboard.setData(ClipboardData(
                                                    text: myReferralCode[
                                                        'refferal_code']));
                                              });
                                              showToast();
                                            },
                                            child: Image.asset(
                                                'assets/images/copy.png'))
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: media.width * 0.32,
                                bottom: media.width * 0.05),
                            child: Button(
                                onTap: () async {
                                  await Share.share(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      languages[choosenLanguage]
                                                  ['text_invitation_1']
                                              .toString()
                                              .replaceAll(
                                                  '55', package.appName) +
                                          ' ' +
                                          myReferralCode['refferal_code'] +
                                          ' ' +
                                          languages[choosenLanguage]
                                              ['text_invitation_2']);
                                },
                                // text: languages[choosenLanguage]['text_invite']),
                                text: 'Invite'),
                          )
                        ],
                      )
                      // : Container(),
                      ),
                  (internet == false)
                      ? Positioned(
                          top: 0,
                          child: NoInternet(
                            onTap: () {
                              setState(() {
                                internetTrue();
                                _isLoading = true;
                                getReferral();
                              });
                            },
                          ))
                      : Container(),

                  //loader
                  (_isLoading == true)
                      ? const Positioned(top: 0, child: Loading())
                      : Container(),

                  //display toast
                  (_showToast == true)
                      ? Positioned(
                          bottom: media.height * 0.2,
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent.withOpacity(0.6)),
                            child: Text(
                              languages[choosenLanguage]['text_code_copied'],
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * twelve,
                                  color: Colors.white),
                            ),
                          ))
                      : Container()
                ],
              ),
            );
          }),
    );
  }
}
