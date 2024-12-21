import 'package:chatapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/login_screen.dart';

// splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Set status bar color to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Status bar background color
        statusBarIconBrightness: Brightness.dark, // Status bar icon color
      ),
    );

    Future.delayed(
      const Duration(seconds: 3),
      () {
        // Navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      // Set the AppBar color to white to match the status bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Welcome to My Chat',
          style: TextStyle(color: Colors.black), // Text color for dark icons
        ),
        centerTitle: true,
        elevation: 0, // Optional: Remove AppBar shadow for cleaner look
      ),
      body: Stack(
        children: [
          // App logo
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/wechat.png'),
          ),

          // Footer text
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Text(
              'MADE IN INDIA ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
