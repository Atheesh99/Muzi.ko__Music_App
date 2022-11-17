import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/hive_model.dart';

List<dynamic> recents = [];

var temp;

addrecent({required int index}) {
  if (recents.length < 20) {
    final songs = box.get("musics") as List<LocalSongs>;

    temp = songs.firstWhere((element) =>
        element.id.toString() == audiosongs[index].metas.id.toString());

    if (recents.contains(temp)) {
      recents.remove(temp);
      recents.insert(0, temp);
      box.put("recent", recents);
    } else {
      recents.insert(0, temp);
      box.put("recent", recents);
    }
  } else {
    recents.removeAt(19);
    box.put("recent", recents);
  }
}
