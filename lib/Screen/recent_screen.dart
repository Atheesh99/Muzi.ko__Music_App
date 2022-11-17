import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:music_app/widget/Recent/recent.dart';

class RecentplayedScreen extends StatefulWidget {
  const RecentplayedScreen({super.key});

  @override
  State<RecentplayedScreen> createState() => _RecentplayedScreenState();
}

class _RecentplayedScreenState extends State<RecentplayedScreen> {
  List<Audio> recentAudlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 35, 44),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Recent Songs',
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: RecentList(),
    );
  }
}
