import 'package:camera/camera.dart';
import 'package:chatapp/screens/camera_screen.dart';
import 'package:flutter/material.dart';

import 'commons/splash_screen.dart';
import 'res/colors.dart';

// global object for accessing device screen size
late Size mq;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        // scaffoldBackgroundColor: const Color(0xFF075E54),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryAppColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
