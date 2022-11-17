import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Function/recent.dart';
import 'package:music_app/Screen/playnow_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  int index;
  List<Audio> audiosongs = [];

  MiniPlayer({Key? key, required this.index, required this.audiosongs})
      : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  bool prevvisible = true;
  bool nxtvisible = true;

  bool nextDone = true;
  bool preDone = true;

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
    log("message");
    buttondesable();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PlayNow(
            index: widget.index,
            myaudiosong: audiosongs,
          );
        }));
      },
      child: assetsAudioPlayer.builderCurrent(
          builder: (context, Playing? playing) {
        final myaudio = find(audiosongs, playing!.audio.assetAudioPath);

        return Container(
          height: deviceSize.height * 0.11,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
                width: deviceSize.width * 0.005,
                color: Colors.blue.withOpacity(.50)),
            color: Colors.black.withOpacity(.8),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      QueryArtworkWidget(
                        id: int.parse(myaudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceSize.width * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: deviceSize.width * 0.40,
                            height: deviceSize.height * 0.03,
                            child: Marquee(
                              pauseAfterRound: const Duration(seconds: 3),
                              velocity: 50,
                              blankSpace: 50,
                              text: myaudio.metas.title.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: deviceSize.height * 0.002,
                          ),
                          SizedBox(
                            width: deviceSize.width * 0.20,
                            child: Text(
                              myaudio.metas.artist.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceSize.height * 0.009,
                          ),
                          SizedBox(
                              width: deviceSize.width * 0.41,
                              child: assetsAudioPlayer
                                  .builderRealtimePlayingInfos(
                                      builder: (context, infos) {
                                Duration currentpostion = infos.currentPosition;
                                Duration totalduration = infos.duration;
                                return ProgressBar(
                                  progressBarColor: Colors.cyan,
                                  thumbColor: Colors.white,
                                  thumbRadius: 3,
                                  timeLabelTextStyle: TextStyle(
                                    color: Colors.black.withOpacity(.010),
                                  ),
                                  baseBarColor: Colors.grey,
                                  barHeight: deviceSize.height * 0.003,
                                  progress: currentpostion,
                                  total: totalduration,
                                  onSeek: (to) {
                                    assetsAudioPlayer.seek(to);
                                  },
                                );
                              })),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      prevvisible
                          ? Visibility(
                              visible: prevvisible,
                              child: IconButton(
                                onPressed: () {
                                  setState(() async {
                                    widget.index = widget.index + 1;
                                    if (widget.index != audiosongs.length - 1) {
                                      nxtvisible = true;
                                    }
                                    if (preDone) {
                                      preDone = false;
                                      await assetsAudioPlayer.previous();
                                      preDone = true;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.skip_previous_outlined,
                                  color: Colors.white,
                                  size: deviceSize.width * 0.09,
                                ),
                              ),
                            )
                          : const SizedBox(
                              width: 10,
                            ),
                      PlayerBuilder.isPlaying(
                        player: assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          return GestureDetector(
                            onTap: () async {
                              await assetsAudioPlayer.playOrPause();
                            },
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: deviceSize.width * 0.09,
                            ),
                          );
                        },
                      ),
                      // SizedBox(
                      //   width: deviceSize.width * 0.001,
                      // ),
                      nxtvisible
                          ? Visibility(
                              visible: nxtvisible,
                              child: IconButton(
                                onPressed: () {
                                  addrecent(index: widget.index);
                                  setState(() {
                                    widget.index = widget.index + 1;
                                    if (widget.index > 0) {
                                      prevvisible = true;
                                    }
                                    if (nextDone) {
                                      nextDone = false;
                                      assetsAudioPlayer.next();
                                      nextDone = true;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.skip_next_outlined),
                                color: Colors.white,
                                iconSize: deviceSize.width * 0.09,
                              ),
                            )
                          : const SizedBox(
                              width: 10,
                            ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 4),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
