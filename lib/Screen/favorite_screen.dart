import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/widget/favorite/favoritelist.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      backgroundColor: Color.fromARGB(255, 29, 35, 35),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Favourities',
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 21,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: FavoriteList(),
    );
  }
}
