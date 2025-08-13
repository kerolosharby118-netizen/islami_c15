import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Hadeth{
  String title;
  String content;
  Hadeth(this.title,this.content);
}
class AhadethTab extends StatefulWidget {

  const AhadethTab({super.key});

  @override
  State<AhadethTab> createState() => _AhadethTabState();
}

class _AhadethTabState extends State<AhadethTab> {
  List <Hadeth> ahadeth =[];

  @override
  void initState(){
    super.initState();
    readAhadethFile();
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void readAhadethFile()async{
    String ahadethFile = await rootBundle.loadString("assets/files/ahadeth.txt,");
  }
}
