import 'package:flutter/material.dart';

class ContainerBOx extends StatelessWidget {
  const ContainerBOx(
      {Key? key, required this.folderimage, required this.textfolder})
      : super(key: key);

  final String folderimage;
  final String textfolder;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(03),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            width: size.width * 0.33,
            height: size.height * 0.13,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 199, 196, 196),
                    offset: Offset(
                      2.0,
                      2.0,
                    ),
                    blurRadius: 2.10,
                    spreadRadius: 3.0,
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 9, 9, 9),
                    offset: Offset(
                      2.0,
                      3.0,
                    ),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
              child: Center(
                child: Image.asset(
                  folderimage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade800.withOpacity(0.12),
                padding:
                    //EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 15),
                    const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.white),
                ),
              ),
              onPressed: () {},
              child: Text(
                textfolder,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
