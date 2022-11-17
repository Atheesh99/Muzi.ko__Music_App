import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/Screen/screensetting_style.dart';
import 'package:music_app/text/privacy.dart';
import 'package:music_app/text/terms_condition.dart';

import 'package:share_plus/share_plus.dart';

bool temp = true;

class SettingsLIst extends StatefulWidget {
  const SettingsLIst({super.key});

  @override
  State<SettingsLIst> createState() => _SettingsLIstState();
}

class _SettingsLIstState extends State<SettingsLIst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 11, 23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 21,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40, left: 20),
        child: Column(
          children: [
            //settingslist(icon: Icons.person_outline_outlined, title: 'Profile'),
            GestureDetector(
              onTap: () async {
                await Share.share('Download MUSI.Co from playstore ...!');
              },
              child: settingslist(icon: Icons.share_outlined, title: 'share'),
            ),
            const Divider(
              endIndent: 30,
              indent: 10,
              color: Colors.grey,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ScreenSettingTile(
                        screenName: 'Terms And Conditions');
                  },
                ));
              },
              child: settingslist(
                  icon: Icons.mark_unread_chat_alt_sharp,
                  title: 'Terms & Condition'),
            ),
            const Divider(
              endIndent: 30,
              indent: 10,
              color: Colors.grey,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Theme(
                        data: ThemeData(
                          textTheme: const TextTheme(
                            bodyText2: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Poppins',
                            ),
                            subtitle1: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Poppins',
                            ),
                            caption: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            headline6: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          cardColor: Colors.grey.shade300,
                          appBarTheme: const AppBarTheme(
                            backgroundColor: Color.fromARGB(255, 30, 33, 35),
                            elevation: 0,
                          ),
                        ),
                        child: const LicensePage(
                          applicationName: 'M U Z I .K O',
                          applicationVersion: '1.0.0',
                        ),
                      );
                    },
                  ),
                );
              },
              child: settingslist(
                icon: Icons.security,
                title: 'Licenses',
              ),
            ),
            const Divider(
              endIndent: 30,
              indent: 10,
              color: Colors.grey,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ScreenSettingTile(screenName: 'Privacy Policy');
                  },
                ));
              },
              child: settingslist(
                  icon: Icons.privacy_tip_outlined, title: 'Privacy policy'),
            ),
            const Divider(
              endIndent: 30,
              indent: 10,
              color: Colors.grey,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Column(
                        children: const [
                          Text(
                            "M U Z I .K O",
                            style: TextStyle(
                                color: Color.fromARGB(255, 4, 108, 108),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('1.0.0')
                        ],
                      ),
                      content: const Text(
                          'MUZIKO is designed and developed by\n ATHEESH K'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Color(0xffdd0021),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: settingslist(icon: Icons.info_outline, title: 'About Us'),
            ),
            const Divider(
              endIndent: 30,
              indent: 10,
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget settingslist({
    required icon,
    required title,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          letterSpacing: 1,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
