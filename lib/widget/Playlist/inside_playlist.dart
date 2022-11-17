import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/playaudio/open_audio.dart';
import 'package:music_app/Model/box_class.dart';
import 'package:music_app/widget/Mini%20Player/min_player.dart';
import 'package:music_app/widget/Playlist/add_song_playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../Function/function.dart';

// ignore: must_be_immutable
class InsidePlaylist extends StatefulWidget {
  String playlistName;
  InsidePlaylist({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<InsidePlaylist> createState() => _InsidelistState();
}

class _InsidelistState extends State<InsidePlaylist> {
  final box = Boxes.getinstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blueGrey,
        elevation: 10,
        // title: Text(
        //   widget.playlistName,
        //   style: const TextStyle(
        //       fontFamily: "poppinz",
        //       fontSize: 30,
        //       color: Colors.cyanAccent,
        //       fontWeight: FontWeight.w500),
        // ),
        title: Text(
          widget.playlistName,
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey.shade50.withOpacity(0.2),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.grey.shade400,
                    context: context,
                    builder: (context) {
                      return AddsongPlaylist(
                        playlistName: widget.playlistName,
                      );
                    });
              },
              icon: const Icon(
                Icons.playlist_add_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, boxes, _) {
                    final playlistSongs = box.get(widget.playlistName)!;
                    return playlistSongs.isEmpty
                        ? const SizedBox(
                            child: Center(
                              child: Text(
                                "No Songs Here",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: playlistSongs.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                for (var element in playlistSongs) {
                                  playlistsplay.add(
                                    Audio.file(
                                      element.uri!,
                                      metas: Metas(
                                        title: element.title,
                                        id: element.id.toString(),
                                        artist: element.artist,
                                      ),
                                    ),
                                  );
                                }

                                PlayMyAudio(
                                        allsongs: playlistsplay, index: index)
                                    .openAsset(
                                        index: index, audios: playlistsplay);

                                showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  backgroundColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                  context: context,
                                  builder: (ctx) => MiniPlayer(
                                    index: index,
                                    audiosongs: playlistsplay,
                                  ),
                                );
                              },
                              child: ListTile(
                                visualDensity: const VisualDensity(
                                  horizontal: 4,
                                ),
                                leading: QueryArtworkWidget(
                                  id: playlistSongs[index].id!,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                      'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                                    ),
                                  ),
                                ),
                                title: Text(
                                  playlistSongs[index].title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    //color: Color(0xff2b2b29),
                                  ),
                                ),
                                subtitle: Text(
                                  playlistSongs[index].artist!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      // color: Color(0xff2b2b29),
                                      color: Colors.white),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      playlistSongs.removeAt(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        content: const Text(
                                          "Removed From Playlist",
                                          style: TextStyle(
                                            fontFamily: "poppinz",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        backgroundColor:
                                            const Color(0xffdd0021),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black87,
                                    size: 27,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
