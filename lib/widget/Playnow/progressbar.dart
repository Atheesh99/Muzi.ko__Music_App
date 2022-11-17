import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';

class MyPrograsBar extends StatefulWidget {
  const MyPrograsBar({Key? key}) : super(key: key);

  @override
  State<MyPrograsBar> createState() => _MyPrograsBarState();
}

class _MyPrograsBarState extends State<MyPrograsBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: assetsAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, Infos) {
          Duration currentposition = Infos.currentPosition;
          Duration totaldur = Infos.duration;
          return ProgressBar(
            timeLabelTextStyle:
                const TextStyle(color: Color.fromARGB(255, 162, 160, 160)),
            bufferedBarColor: const Color(0xff8A9A9D),
            baseBarColor: const Color(0xff8A9A9D),
            progressBarColor: const Color(0xff00C2CB),
            thumbColor: const Color(0xff00C2CB),
            progress: currentposition,
            total: totaldur,
            onSeek: (duration) {
              assetsAudioPlayer.seek(duration);
            },
          );
        },
      ),
    );
  }
}
