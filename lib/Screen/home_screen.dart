import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Function/most_played.dart';
import 'package:music_app/Function/playaudio/open_audio.dart';
import 'package:music_app/Function/recent.dart';

import 'package:music_app/widget/Drawer/drawer.dart';

import 'package:music_app/widget/Homescreen/alert_box_menuvert_.dart';

import 'package:music_app/widget/Homescreen/home_container.dart';

import 'package:music_app/widget/Homescreen/search.dart';
import 'package:music_app/widget/Mini%20Player/min_player.dart';

import 'package:on_audio_query/on_audio_query.dart';

List<dynamic>? recentsongsdy = [];
List<dynamic> recents = [];

class Homescreen extends StatefulWidget {
  Homescreen({Key? key, required this.audiosongs}) : super(key: key);
  List<Audio> audiosongs = [];
  @override
  State<Homescreen> createState() => _AllSongsState();
}

class _AllSongsState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    databasesongs = box.get('musics');
    likedsongs = box.get("favorites")!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(116, 2, 2, 31),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
              color: Color(0xff00C2CB),
              height: size.height * 0.5,
              width: size.width * 0.1,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Your Libary',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff00C2CB),
              ),
            )
          ],
        ),
        actions: [
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => SearchScreen()),
                  ),
                );
              },
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      drawer: const Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(40),
          ),
        ),
        backgroundColor: Color.fromARGB(223, 88, 90, 95),
        child: DrawerScreen(),
      ),
      body: Column(
        children: [
          HomeContainer(size: size),
          //SizedBox(height: size.height * 0.03),

          Container(
            height: 50,
            color: Colors.transparent,
            child: const Center(
              child: Text(
                'All Songs',
                style: TextStyle(
                    color: Color.fromARGB(255, 163, 245, 250),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 2),
              ),
            ),
          ),
          widget.audiosongs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                      Text(
                        "NO Songs Are Found",
                        style: TextStyle(
                          fontFamily: "poppinz",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ])
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 199, 196, 196),
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 3.0,
                                  spreadRadius: 0.10,
                                ),
                                BoxShadow(
                                  color: Color.fromARGB(255, 12, 11, 31),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: ListTile(
                              visualDensity: const VisualDensity(
                                horizontal: 4,
                              ),
                              onTap: () {
                                addrecent(index: index);
                                showBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30.0),
                                      bottom: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (ctx) => MiniPlayer(
                                      index: index, audiosongs: audiosongs),
                                );
                                PlayMyAudio(
                                        index: index,
                                        allsongs: widget.audiosongs)
                                    .openAsset(
                                        audios: audiosongs, index: index);
                                addmostplayed(index: index);
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  AlertTrail.trailAlert(context, index);
                                },
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                audiosongs[index].metas.title.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                audiosongs[index].metas.artist.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              leading: QueryArtworkWidget(
                                id: int.parse(
                                    audiosongs[index].metas.id.toString()),
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                    'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: audiosongs.length,
                  ),
                ),
        ],
      ),
    );
  }
}
