import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';

import 'package:music_app/Model/hive_model.dart';
import 'package:music_app/widget/Mini%20Player/min_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../Function/playaudio/open_audio.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<LocalSongs> songsdb = [];
  List<Audio> songall = [];
  String search = '';

  getSongs() {
    songsdb = box.get("musics") as List<LocalSongs>;

    for (var element in songsdb) {
      songall.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    }
  }

  Future<String> debounce() async {
    return "Waited 1";
  }

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    List<Audio> searchresult = songall
        .where((element) =>
            element.metas.title!.toLowerCase().startsWith(search.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for Songs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    fillColor: Colors.grey,
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff2b2b29), width: 2.0),
                    ),
                    hintText: 'search for song',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff2b2b29), width: 2.0),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.white)),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            search.isNotEmpty
                ? searchresult.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: searchresult.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: debounce(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();

                                        showBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                            ),
                                            backgroundColor: Colors.blueGrey
                                                .withOpacity(0.8),
                                            context: context,
                                            builder: (ctx) => MiniPlayer(
                                                index: index,
                                                audiosongs: searchresult));

                                        PlayMyAudio(
                                                allsongs: searchresult,
                                                index: index)
                                            .openAsset(
                                                audios: audiosongs,
                                                index: index);
                                      },
                                      child: ListTile(
                                        leading: QueryArtworkWidget(
                                          id: int.parse(searchresult[index]
                                              .metas
                                              .id
                                              .toString()),
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            backgroundImage: AssetImage(
                                              'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          searchresult[index].metas.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          searchresult[index].metas.artist!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                });
                          },
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(30),
                        child: Center(
                          child: Text(
                            'No Result Found',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                : Expanded(
                    child: ListView.builder(
                      itemCount: audiosongs.length,
                      itemBuilder: (context, index) => ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: 4,
                        ),
                        leading: QueryArtworkWidget(
                          id: int.parse(audiosongs[index].metas.id.toString()),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/image/360_F_195820215_3qBs8o8cUenR6H9ZWIjnKe60IXSb1xjv-removebg-preview.png',
                            ),
                          ),
                        ),
                        title: Text(
                          audiosongs[index].metas.title.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          audiosongs[index].metas.artist.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
