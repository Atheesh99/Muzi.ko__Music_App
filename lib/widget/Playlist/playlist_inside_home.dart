import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/box_class.dart';
import 'package:music_app/Model/hive_model.dart';

class PlaylistNow extends StatelessWidget {
  PlaylistNow({Key? key, required this.song}) : super(key: key);
  Audio song;

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getinstance();
    playlists = box.keys.toList();
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 104, 105, 105),
        // color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey.shade300,
                  title: const Text("Add new Playlist",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "poppinz",
                          color: Color(0xff2b2b29),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  content: TextField(
                    style: const TextStyle(
                      color: Color(0xff2b2b29),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: 'Create a Playlist',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      playlistName = value;
                    },
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          List<LocalSongs> librayry = [];
                          List? excistingName = [];
                          if (playlists.isNotEmpty) {
                            excistingName = playlists
                                .where((element) => element == playlistName)
                                .toList();
                          }

                          if (playlistName != '' &&
                              playlistName != 'favourites' &&
                              playlistName != 'recent' &&
                              excistingName.isEmpty) {
                            box.put(playlistName, librayry);
                            Navigator.of(context).pop();

                            playlists = box.keys.toList();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          "ADD",
                          style: TextStyle(
                              fontFamily: "poppinz",
                              color: Color(0xff2b2b29),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              leading: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 23,
                ),
              ),
              title: const Text(
                "Create  Playlist",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18),
              ),
            ),
          ),
          ...playlists
              .map((e) => e != "musics" && e != "favorites" && e != 'recent'
                  ? libraryList(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Container(
                        height: 75,
                        width: 95,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: ListTile(
                            onTap: () async {
                              playlistSongs = box.get(e);
                              List existingSongs = [];
                              existingSongs = playlistSongs!
                                  .where((element) =>
                                      element.id.toString() ==
                                      song.metas.id.toString())
                                  .toList();

                              if (existingSongs.isEmpty) {
                                final songs =
                                    box.get("musics") as List<LocalSongs>;
                                final temp = songs.firstWhere((element) =>
                                    element.id.toString() ==
                                    song.metas.id.toString());
                                playlistSongs?.add(temp);

                                await box.put(e, playlistSongs!);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(milliseconds: 400),
                                  content: const Text(
                                    "Added to Playlist",
                                    style: TextStyle(
                                      fontFamily: "poppinz",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Color(0xffdd0021),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ));
                              } else {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(milliseconds: 400),
                                  content: const Text(
                                    "Already in Playlist",
                                    style: TextStyle(
                                      fontFamily: "poppinz",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: const Color(0xffdd0021),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ));
                              }
                            },
                            leading: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.cyan.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Icon(
                                Icons.queue,
                                color: Color(0xff2b2b29),
                              ),
                            ),
                            title: Text(
                              e.toString(),
                              style: const TextStyle(
                                  fontFamily: "poppinz",
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2b2b29),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ))
                  : Container())
              .toList()
        ],
      ),
    );
  }

  Padding libraryList({required child}) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: child);
  }
}
