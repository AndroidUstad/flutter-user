import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/about.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/editprofile.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/faq.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/favourite.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/history.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/makecomplaint.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/referral.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/selectlanguage.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/sos.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/walletpage.dart';
import 'package:tagyourtaxi_driver/pages/onTripPage/map_page.dart';
import 'package:tagyourtaxi_driver/styles/styles.dart';
import 'package:tagyourtaxi_driver/translations/translation.dart';

import '../NavigatorPages/notification.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      color: page,
      width: media.width * 0.8,
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Drawer(
            child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 184,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/images/oval.png'),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  width: media.width * 0.035,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: media.width * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: media.width * 0.3,
                            child: Text(
                              'Kimmy Natasa',
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontSize: 32,
                                  // fontWeight: FontWeight.bold,
                                  color: textColor),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.01,
                    ),
                    SizedBox(
                      width: media.width * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            // userDetails['email'],
                            'Verified',
                            style: TextStyle(
                              fontFamily: 'Inter-Regular',
                              fontSize: 28,
                              // fontWeight: FontWeight.bold,
                              color: Color(0xffBDBCBC),
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          Image.asset(
                            'assets/images/Verified.png',
                            fit: BoxFit.contain,
                            width: media.width * 0.075,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: media.width * 0.05),
              width: media.width * 0.7,
              child: Column(
                children: [
                  //Notification
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const History()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/notification.png',
                            width: 25.96,
                            height: 24.58,
                            color: Color(0xff369CC7),
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              'Notification',
                              // languages[choosenLanguage]
                              //     ['text_enable_history'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //history
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const History()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/history_icon.png',
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              'Ride History',
                              // languages[choosenLanguage]
                              //     ['text_enable_history'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //referral page
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReferralPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/referal.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]
                              //     ['text_enable_referal'],
                              'Referal',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //Favourites
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const WalletPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/favourites.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                            color: Color(0xff369CC7),
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              'Favourites',
                              // languages[choosenLanguage]
                              //     ['text_enable_wallet'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //faq
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Faq()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/faq.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]['text_faq'],
                              'FAQ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //sos
                  InkWell(
                    onTap: () async {
                      var nav = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Sos()));
                      if (nav) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/sos.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]['text_sos'],
                              'SOS',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //select language
                  InkWell(
                    onTap: () async {
                      var nav = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectLanguage()));
                      if (nav) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/changelanguage.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]
                              //     ['text_change_language'],
                              'Change Language',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //make complaints
                  InkWell(
                    onTap: () async {
                      var nav = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MakeComplaint(
                                    fromPage: 0,
                                  )));
                      if (nav) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/complaints.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]
                              //     ['text_make_complaints'],
                              'Complaints',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //about

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/About.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]['text_about'],
                              'About',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //delete account
                  InkWell(
                    onTap: () {
                      setState(() {
                        deleteAccount = true;
                      });
                      valueNotifierHome.incrementNotifier();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/delete.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]
                              //     ['text_delete_account'],
                              'Delete Account',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.015,
                  ),
                  //logout
                  InkWell(
                    onTap: () {
                      setState(() {
                        logout = true;
                      });
                      valueNotifierHome.incrementNotifier();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/logout.png',
                            fit: BoxFit.contain,
                            width: 25.96,
                            height: 24.58,
                          ),
                          SizedBox(
                            width: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.55,
                            child: Text(
                              // languages[choosenLanguage]['text_logout'],
                              'Logout',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontSize: 23,
                                // fontWeight: FontWeight.bold,
                                color: textColor2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        )),
      ),
    );
  }
}
