import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:marquee/marquee.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Function/recent.dart';
import 'package:music_app/Model/hive_model.dart';

import 'package:music_app/widget/Playlist/playlist_inside_home.dart';
import 'package:music_app/widget/Playnow/progressbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayNow extends StatefulWidget {
  Audio? song;
  List<Audio> myaudiosong = [];
  int index;
  PlayNow({
    Key? key,
    song,
    required this.myaudiosong,
    required this.index,
  }) : super(key: key);

  @override
  State<PlayNow> createState() => _PlayNowState();
}

class _PlayNowState extends State<PlayNow> {
  bool nextDone = true;
  bool preDone = true;

  int repeat = 0;
  // List<dynamic> likedSongS = [];

  bool prevvisible = true;
  bool nxtvisible = true;

  buttondesable() {
    if (widget.index == 0) {
      prevvisible = false;
    } else {
      prevvisible = true;
    }

    if (widget.index == audiosongs.length - 1) {
      nxtvisible = false;
    } else {
      nxtvisible = true;
    }
  }

  @override
  void initState() {
    buttondesable();
    super.initState();
    databaseSong = box.get('musics') as List<LocalSongs>;

    assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    Size divsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 5, 9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: CircleAvatar(
              backgroundColor: Colors.blueGrey.withOpacity(.1),
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 30,
              ),
            )),
        title: Text(
          'Now PlayinG',
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: assetsAudioPlayer.builderCurrent(
          builder: (context, Playing? playing) {
        final myAudio = find(widget.myaudiosong, playing!.audio.assetAudioPath);
        final currentSong = databaseSong.firstWhere(
            (element) => element.id.toString() == myAudio.metas.id.toString());

        if (playing.audio.assetAudioPath.isEmpty) {
          return const Center(
            child: Text('Loading.....!'),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: divsize.width * 0.80,
                height: divsize.height * 0.35,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     color: Colors.grey),
                margin: const EdgeInsets.only(left: 50, top: 40, right: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: QueryArtworkWidget(
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      child: Image.asset(
                        'assets/image/mucis bkg.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: divsize.height * 0.04,
              ),
              SizedBox(
                width: divsize.width * 0.80,
                height: divsize.height * 0.04,
                child: Marquee(
                  pauseAfterRound: const Duration(seconds: 2),
                  velocity: 40,
                  blankSpace: 44,
                  text: myAudio.metas.title.toString(),
                  style: GoogleFonts.syncopate(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: divsize.width * 0.42,
                height: divsize.height * 0.05,
                child: Marquee(
                  pauseAfterRound: const Duration(seconds: 5),
                  velocity: 35,
                  blankSpace: 30,
                  text: myAudio.metas.artist.toString(),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Color.fromARGB(255, 204, 205, 205),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(
                height: divsize.height * 0.02,
              ),
              ///////////////////////////////  Favorites__Start  //////////////////////
              Row(
                children: [
                  SizedBox(
                    width: divsize.width * 0.02,
                  ),
                  likedsongs
                          .where((element) =>
                              element.id.toString() ==
                              currentSong.id.toString())
                          .isEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            likedsongs.add(currentSong);
                            box.put("favorites", likedsongs);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(milliseconds: 400),
                              content: const Text(
                                "Added to Favourites",
                                style: TextStyle(
                                  fontFamily: "poppinz",
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.grey.shade100,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ));
                            setState(() {});
                          },
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Color(0xff00C2CB),
                          ),
                          onPressed: () async {
                            setState(() {
                              likedsongs.removeWhere((elemet) =>
                                  elemet.id.toString() ==
                                  currentSong.id.toString());
                              box.put("favorites", likedsongs);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(milliseconds: 400),
                              content: const Text(
                                "Removed From Favourites",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.grey.shade100,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ));
                          },
                        ),
                  //////////////////// faviorite___ End ///////////////
                  SizedBox(
                    width: divsize.width * 0.58,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (repeat % 2 == 0) {
                          assetsAudioPlayer.setLoopMode(LoopMode.single);
                          repeat++;
                        } else {
                          assetsAudioPlayer.setLoopMode(LoopMode.none);
                          repeat++;
                        }
                      });
                    },
                    icon: repeat % 2 == 0
                        ? const Icon(
                            Icons.repeat,
                          )
                        : const Icon(Icons.repeat_one),
                    color: Colors.white,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          assetsAudioPlayer.toggleShuffle();
                        });
                      },
                      icon: assetsAudioPlayer.isShuffling.value
                          ? const Icon(
                              Icons.shuffle_on_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.shuffle,
                              color: Colors.white,
                            )),
                ],
              ),
              const MyPrograsBar(),
              SizedBox(
                height: divsize.height * 0.10,
                width: divsize.width * 0.60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey.withOpacity(0.2),
                      radius: 30,
                      child: GestureDetector(
                        onTap: () async {
                          await assetsAudioPlayer.previous();

                          addrecent(index: widget.index);
                        },
                        child: Icon(
                          Icons.skip_previous_sharp,
                          size: divsize.width * 0.1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.cyan.withOpacity(0.5),
                      radius: 30,
                      child: PlayerBuilder.isPlaying(
                          player: assetsAudioPlayer,
                          builder: (context, isPlaying) {
                            return GestureDetector(
                              onTap: () async {
                                await assetsAudioPlayer.playOrPause();
                              },
                              child: Icon(
                                isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow_rounded,
                                size: divsize.width * 0.1,
                                color: Colors.white,
                              ),
                            );
                          }),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey.withOpacity(0.2),
                      radius: 30,
                      child: GestureDetector(
                        onTap: () async {
                          await assetsAudioPlayer.next();

                          // Recent.AddToRecent(songId: myAudio.metas.id!);
                          addrecent(index: widget.index);
                        },
                        child: Icon(
                          Icons.skip_next_sharp,
                          size: divsize.width * 0.1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: divsize.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) => PlaylistNow(song: myAudio));
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   duration: const Duration(milliseconds: 400),
                  //   content: const Text(
                  //     "Added to Playlist",
                  //     style: TextStyle(
                  //       fontFamily: "poppinz",
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   backgroundColor: Colors.red.shade400,
                  //   behavior: SnackBarBehavior.floating,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  // ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.playlist_add,
                      color: Color.fromARGB(255, 130, 232, 250),
                    ),
                    SizedBox(
                      width: divsize.width * 0.03,
                    ),
                    const Text(
                      'Add to playlist',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
