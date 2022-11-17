import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/hive_model.dart';
import 'package:music_app/widget/Playlist/edit_playlist.dart';
import 'package:music_app/widget/Playlist/inside_playlist.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late TextEditingController controller;

  String? title;
  final formkey = GlobalKey<FormState>();

  final existingPlaylist = SnackBar(
    duration: const Duration(milliseconds: 400),
    content: const Text(
      "Playlist name already exist",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 27, 39),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Playlist',
          style: GoogleFonts.syncopate(
            textStyle: const TextStyle(
              fontSize: 21,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: ((context, boxes, _) {
          playlists = box.keys.toList();
          if (playlists.isEmpty) {
            return const Center(
              child: Text(
                "NO Playllist",
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
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 0,
                );
              },
              itemCount: playlists.length,
              itemBuilder: (contex, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InsidePlaylist(
                        playlistName: playlists[index],
                      ),
                    ),
                  );
                },
                child: playlists[index] != "musics" &&
                        playlists[index] != "favorites" &&
                        playlists[index] != "recent"
                    ? libraryList(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              color: Colors.white.withOpacity(0.9),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.cyan.withOpacity(0.8),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    width: 110,
                                    height: 100,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.playlist_play_outlined,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          playlists[index].toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '${listLength(listName: playlists[index]).toString()} Songs',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return EditplayList(
                                            playlistNameForEdit:
                                                playlists[index],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.edit_note_sharp),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showCupertinoDialog(
                                        context: contex,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: const Text(
                                                "Do you want to delete"),
                                            content: const Text(
                                                "It will be deleted form your Playlist"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                onPressed: () {
                                                  box.delete(playlists[index]);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(
                                                          milliseconds: 400),
                                                      content: const Text(
                                                        "Deleted Successfully",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  );
                                                  setState(() {
                                                    playlists =
                                                        box.keys.toList();
                                                  });
                                                  Navigator.pop(contex);
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                onPressed: (() {
                                                  Navigator.of(context).pop();
                                                }),
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
            );
          }
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          backgroundColor: const Color.fromARGB(255, 10, 238, 242),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                      width: 300,
                      height: 170,
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: 'Add  To ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                ),
                                children: [
                                  TextSpan(
                                      text: ' PLaylist',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.red)),
                                ]),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Form(
                            key: formkey,
                            child: TextFormField(
                              controller: controller,
                              style: const TextStyle(
                                color: Color(0xff2b2b29),
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffdd0021), width: 2),
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  hintText: 'Create a Playlist',
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff2b2b29),
                                      width: 2.0,
                                    ),
                                  )),
                              onChanged: ((value) {
                                title = value.trim();
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  submit();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.playlist_add_check_circle,
                                    color: Colors.cyan[800],
                                    size: 28,
                                  ),
                                  const Text(
                                    '   Add Playlist',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Padding libraryList({required child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: child,
    );
  }

  void submit() {
    playlistName = controller.text;
    List<LocalSongs> librayry = [];
    List? excistingName = [];
    if (playlists.isNotEmpty) {
      excistingName =
          playlists.where((element) => element == playlistName).toList();
    }

    if (playlistName != '' &&
        excistingName.isEmpty &&
        formkey.currentState!.validate()) {
      box.put(playlistName, librayry);
      Navigator.of(context).pop();
      setState(() {
        playlists = box.keys.toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
    }

    controller.clear();
  }
}

int listLength({required listName}) {
  final g = box.get(listName)!;
  return g.length;
}
