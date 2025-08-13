import 'package:flutter/material.dart';
import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/screans/home/tabs/quran/sura_row.dart';
import 'package:islami/ui/screans/sura_details/sura_details.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_constants.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
          Expanded(child: buildSurasListView()),
        ],
      ),
    );
  }
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
          onTap: (){
            Navigator.pushNamed(context, SuraDetails.routename , arguments:sura );
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
