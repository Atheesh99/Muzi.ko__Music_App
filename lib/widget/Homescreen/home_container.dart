import 'package:flutter/material.dart';
import 'package:music_app/Screen/favorite_screen.dart';
import 'package:music_app/Screen/mostplayed_screen.dart';
import 'package:music_app/Screen/playlist_screen.dart';
import 'package:music_app/Screen/recent_screen.dart';
import 'package:music_app/widget/Homescreen/container_box.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.22,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            child: const ContainerBOx(
                folderimage:
                    'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                textfolder: 'Playlists'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => PlaylistScreen()));
            },
          ),
          InkWell(
            child: const ContainerBOx(
                folderimage:
                    'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                textfolder: 'Favorite'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => FavoriteScreen()));
            },
          ),
          InkWell(
            child: const ContainerBOx(
                folderimage:
                    'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                textfolder: 'Recent Songs'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => RecentplayedScreen()));
            },
          ),
          InkWell(
            child: const ContainerBOx(
                folderimage:
                    'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                textfolder: 'Most played'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => MostplayedScreen()));
            },
          ),
        ],
      ),
    );
  }
}
