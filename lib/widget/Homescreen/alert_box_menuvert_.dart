import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/hive_model.dart';
import 'package:music_app/widget/Playlist/playlist_inside_home.dart';

class AlertTrail {
  static trailAlert(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
            backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  showBottomSheet(
                      context: context,
                      builder: (context) =>
                          PlaylistNow(song: audiosongs[index]));
                },
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    showModalBottomSheet(
                      backgroundColor: const Color(0xffdd0021),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) =>
                          PlaylistNow(song: audiosongs[index]),
                    );
                  },
                  leading: const Icon(
                    Icons.playlist_add,
                    color: Color(0xff00C2CB),
                  ),
                  title: const Text(
                    'Add Playlist',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              // favouite--------------------------------------
              likedsongs
                      .where((element) =>
                          element.id.toString() ==
                          databasesongs![index].id.toString())
                      .isEmpty
                  ? SimpleDialogOption(
                      onPressed: () async {
                        final songs = box.get("musics") as List<LocalSongs>;
                        final temp = songs.firstWhere((element) =>
                            element.id.toString() ==
                            audiosongs[index].metas.id.toString());
                        favorites = likedsongs;
                        favorites.add(temp);
                        box.put("favorites", favorites);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 400),
                          content: const Text(
                            "Added to Favourites",
                            style: TextStyle(
                              fontFamily: "poppinz",
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.greenAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ));

                        Navigator.of(context).pop();
                      },
                      child: const ListTile(
                        leading: Icon(
                          Icons.favorite_border,
                          color: Color(0xff00C2CB),
                        ),
                        title: Text(
                          "Add to Favourites",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  : SimpleDialogOption(
                      onPressed: () async {
                        likedsongs.removeWhere((elemet) =>
                            elemet.id.toString() ==
                            databasesongs![index].id.toString());
                        await box.put("favorites", likedsongs);

                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 400),
                          content: const Text(
                            "Remove from Favourites",
                            style: TextStyle(
                              fontFamily: "poppinz",
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.favorite, color: Color(0xff00C2CB)),
                        title: Text(
                          "Remove From Favourite",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
            ],
          );
        }));
  }
}
