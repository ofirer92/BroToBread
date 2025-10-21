import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/welcome_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'מחשבון לחם אומן',
      debugShowCheckedModeBanner: false,
      
      // Hebrew Localization Support
      locale: const Locale('he'),
      supportedLocales: const [
        Locale('he'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Theme Configuration
      theme: ThemeData(
        // Basic Theme Colors
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFEF3C7), // amber-50
        
        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          primary: const Color(0xFFB45309), // amber-700
          secondary: const Color(0xFF78350F), // amber-900
          surface: Colors.white,
        ),
        
        // Text Theme with Hebrew Font
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Heebo'),
          displayMedium: TextStyle(fontFamily: 'Heebo'),
          displaySmall: TextStyle(fontFamily: 'Heebo'),
          headlineLarge: TextStyle(fontFamily: 'Heebo'),
          headlineMedium: TextStyle(fontFamily: 'Heebo'),
          headlineSmall: TextStyle(fontFamily: 'Heebo'),
          titleLarge: TextStyle(fontFamily: 'Heebo'),
          titleMedium: TextStyle(fontFamily: 'Heebo'),
          titleSmall: TextStyle(fontFamily: 'Heebo'),
          bodyLarge: TextStyle(fontFamily: 'Heebo'),
          bodyMedium: TextStyle(fontFamily: 'Heebo'),
          bodySmall: TextStyle(fontFamily: 'Heebo'),
          labelLarge: TextStyle(fontFamily: 'Heebo'),
          labelMedium: TextStyle(fontFamily: 'Heebo'),
          labelSmall: TextStyle(fontFamily: 'Heebo'),
        ),
        
        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFB45309), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
          alignLabelWithHint: true,
        ),
        
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB45309),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            textStyle: const TextStyle(
              fontFamily: 'Heebo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFB45309),
            textStyle: const TextStyle(
              fontFamily: 'Heebo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Card Theme
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        
        // App Bar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB45309),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Heebo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // Dialog Theme
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: const TextStyle(
            fontFamily: 'Heebo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            fontFamily: 'Heebo',
            fontSize: 16,
          ),
        ),
        
        // Snackbar Theme
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        
        // Icon Theme
        iconTheme: const IconThemeData(
          color: Color(0xFFB45309),
          size: 24,
        ),
        
        // Progress Indicator Theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFB45309),
          linearTrackColor: Color(0xFFE5E7EB),
        ),
      ),
      
      // RTL Text Direction
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      
      home: const WelcomeScreen(),
    );
  }
}