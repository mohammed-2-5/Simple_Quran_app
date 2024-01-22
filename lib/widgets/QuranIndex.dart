import 'package:flutter/material.dart';
import 'package:quran_app/core/arabic_numbers.dart';

import '../SurahBuilder.dart';
import '../core/AyaSymbol.dart';
import '../core/constants.dart';

class QuranIndexCreator extends StatelessWidget {


  const QuranIndexCreator(data, BuildContext context, {
    Key? key,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: ListView.builder(
        itemCount: quran_data.length,
        itemBuilder: (context, index) {
          return  Container(
            color: index % 2 == 0
                ? const Color.fromARGB(255, 253, 247, 230)
                : const Color.fromARGB(255, 253, 251, 240),
            child: TextButton(
              child: Row(
                children: [
                  ArabicSuraNumber(i: index),
                  const SizedBox(
                    width: 5,
                  ),
                 Text(quran_data[index]['type'],style: const TextStyle(
                   color: Colors.black,
                   fontSize: 18,
                   fontWeight: FontWeight.bold
                 ),),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(quran_data[index]['juz'].toString().toArabicNumbers,style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                  const Expanded(child: SizedBox()),
                  Text(
                    quran_data[index]['name'],
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontFamily: 'quran',
                        shadows: [
                          Shadow(
                            offset: Offset(.5, .5),
                            blurRadius: 1.0,
                            color: Color.fromARGB(255, 130, 130, 130),
                          )
                        ]),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              onPressed: () {
                fabIsClicked = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SurahBuilder(
                        arabic: quran[0],
                        sura: index,
                        suraName: quran_data[index]['name'],
                        ayah: 0,
                      )),
                );
              },
            ),
          );
        },
      ),
    );
  }

  
}
