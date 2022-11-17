import 'package:music_app/Function/function.dart';
import 'package:music_app/Model/hive_model.dart';

List<dynamic> mostplayedlistfun = [];
List<dynamic> mostparylist = [];

var mosttemp;
var lasttemp;
int count = 1;

addmostplayed({required int index}) {
  if (mostplayedlistfun.length < 10) {
    final mostsongs = box.get("music") as List<LocalSongs>;
    mosttemp = mostsongs.firstWhere((element) =>
        element.id.toString() == audiosongs[index].metas.id.toString());
    mostplayedlistfun.insert(0, mosttemp);
    box.put("mostplay", mostplayedlistfun);
  } else {
    mostplayedlistfun.remove(9);
    box.put("mostplay", mostplayedlistfun);
  }
}
