import 'package:flutter/material.dart';
import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/screans/home/tabs/quran/sura_row.dart';
import 'package:islami/ui/screans/sura_details/sura_details.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_constants.dart';
import 'package:islami/ui/utils/app_text_styles.dart';
import 'package:islami/ui/utils/most_recent_suras_prefs.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  @override
  void initState(){
    super.initState();
     MostRecentSurasPrefs.loadSurasList().then((_){
      setState(() {

      });
    });





  }

  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.quranBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30),
          Image.asset(AppAssets.islamiLogo),
          buildSearchTexFild(),
          SizedBox(height: 20,),
          Text("Most Recent" , style: AppTextStyel.whiteBold12,),
          if(MostRecentSurasPrefs.surasList.isNotEmpty)Expanded(flex: 3,child: buildMostRecentList()),
          Expanded(flex: 7,child: buildSurasListView()),
        ],
      ),
    );
  }

  Widget buildMostRecentList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: MostRecentSurasPrefs.surasList.length,
      itemBuilder: (context , index){
        var sura = MostRecentSurasPrefs.surasList[index];
      return Container(
        width: MediaQuery.of(context).size.width * .6,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.gold
        , borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(sura.nameEn , style: AppTextStyel.blackBold24,),
              Text(sura.nameAr, style: AppTextStyel.blackBold24),
              Text("${sura.verses } verses", style: AppTextStyel.blackBold16 )
            ],
          ),Expanded(child:
          Image.asset(AppAssets.recentSura))
          
        ],),
      );
      }
    );
  }


  buildSearchTexFild() {
    var defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gold, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
    return TextField(
      decoration: InputDecoration(
        border: defaultBorder,
        focusedBorder: defaultBorder,
        enabledBorder: defaultBorder,
        labelText: "Sura Name",
        labelStyle: AppTextStyel.whiteBold16,
        prefixIcon: ImageIcon(
          AssetImage(AppAssets.icQuaran),
          color: AppColors.gold,
          size: 28,
        ),
      ),style: AppTextStyel.whiteBold16,
      cursorColor: AppColors.gold,
    );
  }
  buildSurasListView() {
    return ListView.separated(
      itemCount: AppConstants.suras.length,
      itemBuilder: (context,index){
        var sura = AppConstants.suras[index];
        return InkWell(
          onTap: ()async{
            MostRecentSurasPrefs.addSuraToPrefs(sura);
            await Navigator.pushNamed(context, SuraDetails.routename , arguments:sura );
            setState((){

            });
          },
          child: SuraRow(sura : sura
          ),
        );
      },
      separatorBuilder:(_ , __) => Divider(
        indent: 64,
        endIndent: 64,
      ),);

  }
}







