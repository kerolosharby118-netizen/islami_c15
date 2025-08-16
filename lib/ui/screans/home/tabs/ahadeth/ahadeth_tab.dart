import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart' show CarouselSlider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/ui/screans/hadeth_details/hadeth_details.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

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
          if (ahadeth.isNotEmpty)
          Expanded(
            child: CarouselSlider.builder(
              itemCount: 15,
              options: CarouselOptions(

                initialPage: ahadeth.length,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: true,
               height: double.infinity,
                scrollDirection: Axis.horizontal,
                enlargeFactor: .1
              ),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                    return buildHadethWidget(itemIndex);
                  },
            ),
          ),
          SizedBox(height: 20 ,)
        ],
      ),
    );
  }

  Widget buildHadethWidget(int itemIndex) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, HadethDetails.routename , arguments:ahadeth[itemIndex] );
      },
      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.hadethBg),
                        ),
                      ),
                      child: Column(
                          children: [
                      SizedBox(height: 20,),
                      Text(ahadeth[itemIndex].title ,
                        style: AppTextStyel.blackBold24,),
                      SizedBox(height: 20),
                      Expanded(
                        child:Container(child:
                          Text(ahadeth[itemIndex].content,
                            style: AppTextStyel.blackBold16,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade ,
                        ),
                        ),
                      ),
                            SizedBox(height: 30,)
      
                      ]
                      ),
                    ),
    );
  }

  void readAhadethFile() async {
    String ahadethFile = await rootBundle.loadString(
      "assets/files/ahadeth.txt",
    );
    List<String> ahadethList = ahadethFile.split("#\r\n");
    for (int i = 0; i < ahadethList.length; i++) {
      String hadeth = ahadethList[i];
      List<String> hadethLines = hadeth.split("\n");
      String title = hadethLines.removeAt(0);
      ahadeth.add(Hadeth(title, hadethLines.join()));
      setState(() {});
    }
  }
}
