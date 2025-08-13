import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/screans/home/tabs/quran/quran_tab.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class SuraDetails extends StatefulWidget {
  static const routename = "SuraDetails";
  const SuraDetails({super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  late SuraDM sura;
  String suraContent = "";
  @override
  Widget build(BuildContext context) {
    sura = ModalRoute.of(context)!.settings.arguments as SuraDM;
    if (suraContent.isEmpty) {
      readSuraContent();
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: AppColors.gold),
        title: Text(sura.nameEn, style: AppTextStyel.goldBold24),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sura.nameAr,
            style: AppTextStyel.goldBold24,
            textAlign: TextAlign.center,
          ),
          suraContent.isEmpty
              ? Center(child: CircularProgressIndicator(color: AppColors.gold))
              : Text(
                  suraContent,
                  style: AppTextStyel.goldBold20,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
        ],
      ),
    );
  }

  void readSuraContent() async {
    String fileName = "assets/files/quran/${sura.index}.txt";
    Future<String> contentFuture = rootBundle.loadString(fileName);
    suraContent = await contentFuture;
    List<String> suraLines = suraContent.trim().split("\n");
    for (int i = 0; i < suraLines.length; i++) {
      suraLines[i] += "[${i+1}]";
    }
    suraContent = suraLines.join();
    setState(() {});
    print(suraContent);
  }
}
