import 'package:flutter/material.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_text_styles.dart' show AppTextStyel;
import 'dart:math';

class SebhaTab extends StatefulWidget {
  static const routName = "SebhaTab";
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab>
    with SingleTickerProviderStateMixin {
  int counter = 0;
  int phraseIndex = 0;
  double rotationAngle = 0.0;

  List<String> phrases = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
  ];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      rotationAngle += pi / 15; // يخلي السبحة تلف تدريجياً

      if (counter % 30 == 0) {
        phraseIndex = (phraseIndex + 1) % phrases.length;
      }
    });

    _controller.forward(from: 0.0); // يشغل الأنيميشن
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.sebhaBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ✅ اللوجو أول حاجة
              Image.asset(
                AppAssets.islamiLogo,
                width: 290,
                height: 170,
              ),

              const SizedBox(height: 30),

              // ✅ النص الرئيسي بخط Janna LT Bold
              const Text(
                "سبح اسم ربك الأعلى",
                style: TextStyle(
                  fontFamily: "JannaLT",
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: _incrementCounter,
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ✅ السبحة هي اللي بتلف
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: rotationAngle,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          AppAssets.sebhaBd,
                          width: 380,
                          height: 380,
                        ),
                      ),

                      // ✅ النصوص (الأذكار + العدّاد) ثابتة
                      Positioned(
                        top: 200, // ↔️ عدّل الرقم حسب مكان الفراغ في الصورة
                        child: Column(
                          children: [
                            Text(
                              phrases[phraseIndex],
                              style: const TextStyle(
                                fontFamily: "JannaLT",
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "$counter",
                              style: const TextStyle(
                                fontFamily: "JannaLT",
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
