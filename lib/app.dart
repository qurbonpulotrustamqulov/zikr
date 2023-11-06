import 'package:flutter/material.dart';
import 'package:untitled/presentation/pages/splash_page/splash_page.dart';

import 'core/controllers/zikr_controller.dart';
import 'core/providers/zikr_provider.dart';

class Tasbeh extends StatelessWidget {
  const Tasbeh({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      controller: ZikrController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(useMaterial3: true),
        home:  const MaterialApp(
          home: SplashPage(),
    )
      ),
    );
  }
}

