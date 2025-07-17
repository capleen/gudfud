import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gudfud/homescreen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 280), () {
      setState(() {
        _opacity = 0.0;
      });
    });
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Or your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo
            Image.asset(
              'assets/gudfud logo.png', // Make sure this path matches your asset
              height: 150, // Adjust size as needed
            ),
            const SizedBox(height: 24),
            // App Name Text
            Text(
              'GudFud',
              style: GoogleFonts.pacifico(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Nutrisi Seimbang, Hidup Senang!',
              style: GoogleFonts.nunito(
                  fontSize: 16, color: Theme.of(context).primaryColorDark),
            )
          ],
        ),
      ),
    );
  }
}
