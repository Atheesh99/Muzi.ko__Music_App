import 'package:flutter/material.dart';
import 'package:music_app/Function/function.dart';

class EditplayList extends StatefulWidget {
  EditplayList({Key? key, required this.playlistNameForEdit}) : super(key: key);
  String playlistNameForEdit;

  @override
  State<EditplayList> createState() => _EditplayListState();
}

class _EditplayListState extends State<EditplayList> {
  late TextEditingController nameController;
  String playlistNewName = '';

  @override
  void initState() {
    nameController =
        TextEditingController(text: widget.playlistNameForEdit.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade400,
      title: const Text(
        'Edit Playlist',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: nameController,
        style: const TextStyle(
          color: Color(0xff2b2b29),
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff2b2b29),
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          playlistNewName = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            List playListnames = box.keys.toList();

            if (!playListnames.contains(playlistNewName)) {
              List<dynamic> playListSongs =
                  box.get(widget.playlistNameForEdit)!;
              box.delete(widget.playlistNameForEdit);
              box.put(playlistNewName, playListSongs);
            } else {
              ScaffoldMessenger(
                child: SnackBar(
                  duration: const Duration(milliseconds: 400),
                  content: Text('$playlistNewName already exist in playlist'),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 400),
                  content: Text(
                    '$playlistNewName already exist in playlist',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color(0xffdd0021),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            "ADD",
            style: TextStyle(
                fontFamily: "poppinz",
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
