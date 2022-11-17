import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/widget/Mini%20Player/min_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../Function/function.dart';
import '../../Function/playaudio/open_audio.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  void initState() {
    likedsongs = box.get("favorites")!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, boxes, _) {
            final likedsongs = box.get("favorites");
            if (likedsongs == null || likedsongs.isEmpty) {
              return const Center(
                child: Text(
                  "NO Favourites",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "poppinz",
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    for (var element in likedsongs) {
                      playLikedSong.add(
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
                    PlayMyAudio(allsongs: playLikedSong, index: index)
                        .openAsset(index: index, audios: playLikedSong);
                    showBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                      context: context,
                      builder: (ctx) =>
                          MiniPlayer(index: index, audiosongs: playLikedSong),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.05),
                      //border: Border.all(color: Colors.blue.shade200),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 199, 196, 196),
                          offset: Offset(
                            3.0,
                            1.0,
                          ),
                          blurRadius: 5.10,
                          spreadRadius: 0.0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 2, 1, 14),
                          offset: Offset(
                            2.0,
                            1.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: 4,
                        ),
                        leading: QueryArtworkWidget(
                          id: int.parse(likedsongs[index].id.toString()),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              likedsongs.removeAt(index);
                              box.put("favorites", likedsongs);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(milliseconds: 400),
                              content: const Text(
                                "Removed From Favourites",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 28,
                            color: Color(0xff00C2CB),
                          ),
                        ),
                        title: Text(
                          likedsongs[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, letterSpacing: 1),
                        ),
                        subtitle: Text(
                          likedsongs[index].artist == '<unknown>'
                              ? 'unknown'
                              : likedsongs[index].artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: likedsongs.length,
              );
            }
          }),
    );
  }
}
