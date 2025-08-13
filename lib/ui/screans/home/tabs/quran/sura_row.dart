import 'package:flutter/material.dart';
import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class SuraRow extends StatelessWidget {
  final SuraDM sura;
  const SuraRow({super.key, required this.sura});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      buildIndexImage(),
      SizedBox(width:24,),
      Expanded(child: buildEnInfo()),
      buildNameAr()
    ]
    );
  }

  Widget buildIndexImage() => Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.suraNumberGround)),

      ),
    child: Center(
        child: Text(sura.index.toString(), style: AppTextStyel.whiteBold14 ,)
    ),
  );

  Widget buildEnInfo() => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sura.nameEn , style:AppTextStyel.whiteBold20,),
        SizedBox(height: 4,),
        Text("${sura.verses}verses" , style: AppTextStyel.whiteBold14,)
      ],
    ),
  );

  Widget buildNameAr() => Container(
    child: Text(sura.nameAr , style: AppTextStyel.whiteBold16,),
  );
}
