import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gudfud/splashscreen.dart';

void main() {
  runApp(const FoodDSSApp());
}

class FoodDSSApp extends StatelessWidget {
  const FoodDSSApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4CAF50);
    const Color primaryColorDark = Color(0xFF388E3C);
    const Color accentColor = Color(0xFFFF9800);
    final Color lightBackgroundColor = Colors.green.shade50.withOpacity(0.5);
    final Color cardBackgroundColor = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GudFud',
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        scaffoldBackgroundColor: lightBackgroundColor,
        fontFamily: GoogleFonts.nunito().fontFamily,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: accentColor, brightness: Brightness.light),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2.0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primaryColorDark),
          titleLarge: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: primaryColorDark),
          titleMedium: GoogleFonts.nunito(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
          bodyMedium: GoogleFonts.nunito(fontSize: 16, color: Colors.black54),
          bodySmall:
              GoogleFonts.nunito(fontSize: 14, color: Colors.grey.shade600),
          labelLarge: GoogleFonts.nunito(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
          color: cardBackgroundColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardBackgroundColor,
          hintStyle: GoogleFonts.nunito(color: Colors.grey.shade400),
          labelStyle: GoogleFonts.nunito(
              color: primaryColor, fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          prefixIconColor: primaryColor,
          suffixIconColor: primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                accentColor, // Tombol utama menggunakan warna aksen
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            textStyle:
                GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                primaryColorDark, // Tombol teks menggunakan hijau tua
            textStyle:
                GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: accentColor, foregroundColor: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}
