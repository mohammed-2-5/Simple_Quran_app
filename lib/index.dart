import 'package:flutter/material.dart';
import 'package:quran_app/widgets/QuranIndex.dart';

import 'SurahBuilder.dart';
import 'core/AyaSymbol.dart';
import 'core/constants.dart';
import 'mydrawer.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go to bookmark',
        backgroundColor: Colors.green,
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookmark() == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahBuilder(
                      arabic: quran[0],
                      sura: bookmarkedSura - 1,
                      suraName: arabic[bookmarkedSura - 1]['sura_name_ar'],
                      ayah: bookmarkedAyah,

                    )));
          }
        },
        child: const Icon(Icons.bookmark),
      ),
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: readJson(),
        builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
            ) {
          return QuranIndexCreator(snapshot.data, context);
        },
      ),
    );
  }

  AppBar CustomAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        //"القرآن",
        "Quran",
        style: TextStyle(
          //fontFamily: 'quran',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color:Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ]),
      ),
      backgroundColor: const Color.fromARGB(255, 56, 115, 59),
    );
  }




}