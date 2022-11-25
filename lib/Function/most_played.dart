import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/hive_model.dart';

List<dynamic> mostplayedlistfun = [];
List<dynamic> mostparylist = [];

var mosttemp;
var lasttemp;

addmostplayed({required int index}) {
  if (mostplayedlistfun.length < 10) {
    final mostsongs = box.get("musics") as List<LocalSongs>;
    mosttemp = mostsongs.firstWhere((element) =>
        element.id.toString() == audiosongs[index].metas.id.toString());
    mostplayedlistfun.add(mosttemp);
    box.put("mostplay", mostplayedlistfun);

    if (mostplayedlistfun.length < 15) {
      int i;
      int count = 0;
      for (i = 0; i < mostplayedlistfun.length; i++) {
        if (mostplayedlistfun[i] == mosttemp) {
          count++;
        }
      }
      if (count >= 3) {
        mostparylist.add(mosttemp);
        box.put("mostplaypry", mostparylist);
      }
    } else {
      mostplayedlistfun.remove(9);
      box.put("mostplay", mostplayedlistfun);
    }
  } else {
    mostparylist.remove(0);
    box.put("mostplaypry", mostparylist);
  }
}
