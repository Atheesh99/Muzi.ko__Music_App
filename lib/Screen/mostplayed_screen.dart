import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/widget/Mini%20Player/min_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Function/playaudio/open_audio.dart';

class MostplayedScreen extends StatefulWidget {
  const MostplayedScreen({super.key});

  @override
  State<MostplayedScreen> createState() => _MostplayedScreenState();
}

class _MostplayedScreenState extends State<MostplayedScreen> {
  List<Audio> mostplayedslist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff091227),
      appBar: AppBar(
        backgroundColor: const Color(0xff091227),
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Most Played',
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Boxes, _) {
            final mostplayedsongs = box.get("mostplay");
            if (mostplayedsongs == null || mostplayedsongs.isEmpty) {
              return const Center(
                child: Text(
                  'No Most played',
                  style: TextStyle(
                      fontSize: 18, letterSpacing: 1, color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    for (var element in mostplayedsongs) {
                      mostplayedslist.add(Audio.file(element.uri!,
                          metas: Metas(
                            id: element.id.toString(),
                            title: element.title,
                            artist: element.artist,
                          )));
                    }
                    PlayMyAudio(
                      allsongs: mostplayedslist,
                      index: index,
                    ).openAsset(index: index, audios: mostplayedslist);

                    showBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) =>
                          MiniPlayer(index: index, audiosongs: audiosongs),
                    );
                  },
                  child: ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      leading: QueryArtworkWidget(
                        id: mostplayedsongs[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipOval(
                          child: Image.asset(
                            'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      title: Text(mostplayedsongs[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      subtitle: Text(
                          mostplayedsongs[index].artist == '<unknown>'
                              ? 'Unknown Artist'
                              : mostplayedsongs[index].artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                          ))),
                ),
                itemCount: mostplayedsongs.length,
              );
            }
          }),
    );
  }
}
