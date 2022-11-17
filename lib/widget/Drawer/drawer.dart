import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Screen/favorite_screen.dart';
import 'package:music_app/Screen/home_screen.dart';
import 'package:music_app/Screen/playlist_screen.dart';
import 'package:music_app/widget/Drawer/settings.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isSwitched = false;

  static bool toggleNotification({required bool isNotificationOn}) {
    isNotificationOn
        ? assetsAudioPlayer.showNotification = true
        : assetsAudioPlayer.showNotification = false;

    assetsAudioPlayer.showNotification ? temp = true : temp = false;
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
            height: 800,
            width: 450,
            color: const Color.fromARGB(255, 112, 224, 230),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(88, 90, 95, 65),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40))),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => Homescreen(
                        audiosongs: audiosongs,
                      )),
                ),
              );
            },
            leading: const Icon(
              Icons.close,
              size: 24,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50),
            margin: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(),
                      ),
                    );
                  },
                  child: drawerlist(
                      icon: Icons.favorite_border_outlined,
                      title: 'Liked Song'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlaylistScreen(),
                    ));
                  },
                  child: drawerlist(
                      icon: Icons.playlist_add_circle_outlined,
                      title: 'Playlist'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notifications_outlined,
                    size: 26,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Notification',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      bool temp = value;
                      temp = toggleNotification(isNotificationOn: value);
                      setState(() {
                        isSwitched = temp;
                      });
                    },
                  ),
                ),
                // drawerlist(icon: Icons.message_rounded, title: 'Contact Us'),
                GestureDetector(
                    child: drawerlist(
                        icon: Icons.settings_outlined, title: 'Settings'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => const SettingsLIst()),
                        ),
                      );
                    }),

                const Padding(
                  padding: EdgeInsets.only(top: 450),
                  child: Text(
                    "Version",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 2, fontSize: 15),
                  ),
                ),
                const Text(
                  "1.0.0",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerlist({
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
