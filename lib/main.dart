import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/Model/box_class.dart';
import 'package:music_app/Model/hive_model.dart';
import 'package:music_app/Screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalSongsAdapter());
  await Hive.openBox<List>(boxname);
  final box = Boxes.getinstance();

  List? favoritekeys1 = box.keys.toList();
  if (!favoritekeys1.contains('favorites')) {
    List<dynamic> favoritelist = [];
    box.put('favorites', favoritelist);
  }
  List? recentkeys1 = box.keys.toList();
  if (!recentkeys1.contains('favorites')) {
    List<dynamic> recentlist = [];
    box.put('recent', recentlist);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
