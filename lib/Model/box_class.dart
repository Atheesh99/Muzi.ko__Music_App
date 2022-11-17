import 'package:hive/hive.dart';

String boxname = 'songs';

class Boxes {
  static Box<List>? _box;

  static Box<List> getinstance() {
    return _box ??= Hive.box(boxname);
  }
}
