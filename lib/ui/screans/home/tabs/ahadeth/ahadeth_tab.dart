import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart' show CarouselSlider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/ui/utils/app_assets.dart';

class Hadeth {
  String title;
  String content;
  Hadeth(this.title, this.content);
}

class AhadethTab extends StatefulWidget {
  const AhadethTab({super.key});

  @override
  State<AhadethTab> createState() => _AhadethTabState();
}

class _AhadethTabState extends State<AhadethTab> {
  List<Hadeth> ahadeth = [];

  @override
  void initState() {
    super.initState();
    readAhadethFile();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.ahadethBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppAssets.islamiLogo),
          CarouselSlider.builder(
            itemCount: 15,
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.hadethBg),
                      ),
                    ),
                    child: Column(children: [

                    ]
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }

  void readAhadethFile() async {
    String ahadethFile = await rootBundle.loadString(
      "assets/files/ahadeth.txt,",
    );
    List<String> ahadethList = ahadethFile.split("#\r\n");
    for (int i = 0; i < ahadethList.length; i++) {
      String hadeth = ahadethList[i];
      List<String> hadethLines = hadeth.split("\n");
      String title = hadethLines.removeAt(0);
      ahadeth.add(Hadeth(title, hadethLines.join()));
    }
  }
}
