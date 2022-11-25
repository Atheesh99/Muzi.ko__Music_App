import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/Function/function.dart';

import 'package:music_app/widget/Mini%20Player/min_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../Function/playaudio/open_audio.dart';

class RecentList extends StatefulWidget {
  const RecentList({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentList> createState() => _RecentListState();
}

class _RecentListState extends State<RecentList> {
  List<Audio> recentAudlist = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, boxes, _) {
            final recentsongs = box.get("recent");

            if (recentsongs == null || recentsongs.isEmpty) {
              return const Center(
                child: Text(
                  "No Recents",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 17,
                    letterSpacing: 1,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    for (var element in recentsongs) {
                      recentAudlist.add(
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

                    PlayMyAudio(allsongs: recentAudlist, index: index)
                        .openAsset(index: index, audios: recentAudlist);
                    showBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        context: context,
                        builder: (context) => MiniPlayer(
                              index: index,
                              audiosongs: recentAudlist,
                            ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 31, 48, 56),
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 199, 196, 196),
                          offset: Offset(
                            0.0,
                            1.0,
                          ),
                          blurRadius: 3.10,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 2, 1, 14),
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: QueryArtworkWidget(
                          id: recentsongs[index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png'),
                          ),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              recentsongs.removeAt(index);
                              box.put("recent", recentsongs); //// recent remove
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 28,
                            color: Colors.white,
                          )),
                      title: Text(
                        recentsongs[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1),
                      ),
                      subtitle: Text(
                        recentsongs[index].artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                itemCount: recentsongs.length,
              );
            }
          },
        ),
      ),
    );
  }
}
