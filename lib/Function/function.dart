import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_app/Model/box_class.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Model/hive_model.dart';

// songs fecting
List<SongModel> allSongs = [];
final box = Boxes.getinstance();

final _audioquery = OnAudioQuery();
List<Audio> audiosongs = [];
List<LocalSongs> mappedsongs = [];
List<LocalSongs> databaseSong = [];
List? databasesongs = [];

//  favorites ____________
List<Audio> playLikedSong = [];

List<dynamic> favorites = [];

fetchingsongs() async {
  bool ispermission = await _audioquery.permissionsStatus();
  if (!ispermission) {
    await _audioquery.permissionsRequest();
  }
  allSongs = await _audioquery.querySongs();
  mappedsongs = allSongs
      .map((e) => LocalSongs(
          title: e.title,
          artist: e.artist,
          id: e.id,
          duration: e.duration,
          uri: e.uri!))
      .toList();

  await box.put("musics", mappedsongs);
  databaseSong = box.get("musics") as List<LocalSongs>;

  databaseSong.forEach((element) {
    audiosongs.add(Audio.file(element.uri.toString(),
        metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist)));
  });
}

//song find and and get id-->
Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

//asset audioplayer object-->
AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');

//fav
List<dynamic> likedsongs = [];

//playlist
List playlists = [];
String? playlistName = '';

List<dynamic>? playlistSongs = [];

List<Audio> playlistsplay = [];

List<LocalSongs> playlistSongmodel = [];
