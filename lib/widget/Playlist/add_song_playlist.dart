import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/box_class.dart';
import 'package:music_app/Model/hive_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddsongPlaylist extends StatefulWidget {
  String playlistName;
  AddsongPlaylist({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<AddsongPlaylist> createState() => _AddsongPlaylistState();
}

class _AddsongPlaylistState extends State<AddsongPlaylist> {
  final box = Boxes.getinstance();

  @override
  void initState() {
    getSongs();
    super.initState();
  }

  getSongs() {
    databaseSong = box.get("musics") as List<LocalSongs>;
    playlistSongmodel = box.get(widget.playlistName)!.cast<LocalSongs>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.2),
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: databaseSong.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: SizedBox(
                  height: 45,
                  width: 45,
                  child: QueryArtworkWidget(
                    id: int.parse(databaseSong[index].id.toString()),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  databaseSong[index].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "poppinz",
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2b2b29),
                      fontSize: 15),
                ),
                trailing: playlistSongmodel
                        .where((element) =>
                            element.id.toString() ==
                            databaseSong[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () async {
                          playlistSongmodel.add(databaseSong[index]);
                          await box.put(widget.playlistName, playlistSongmodel);

                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xff2b2b29),
                        ))
                    : IconButton(
                        onPressed: () async {
                          playlistSongmodel.removeWhere((elemet) =>
                              elemet.id.toString() ==
                              databaseSong[index].id.toString());

                          await box.put(widget.playlistName, playlistSongmodel);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Color(0xff2b2b29),
                        )),
              ),
            );
          },
        ));
  }
}
