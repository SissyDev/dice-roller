import 'package:dnd_dice_roller/screens/dice_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF8B0000),

  primary: const Color(0xFFFFD700),
  onPrimary: const Color(0xFF1A1A1A),
  primaryContainer: const Color(0xFF8B0000),
  onPrimaryContainer: const Color(0xFFFFD700),

  secondary: const Color(0xFFF5E6BE),
  secondaryContainer: const Color(0xFF2B1B17),

  surface: const Color(0xFF1A1A1A),
  onSurface: const Color(0xFFFFD700),
  onSurfaceVariant: const Color(0xFFF5E6BE),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_pietra.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const DiceChoice(),
          ],
        ),

        theme: ThemeData(
          useMaterial3: true,
          colorScheme: kColorScheme,
          scaffoldBackgroundColor: const Color(0xFF1A1A1A),

          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2B1B17),
            foregroundColor: Color(0xFFFFD700),
            elevation: 4,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'MedievalSharp',
              fontSize: 24,
              color: Color(0xFFFFD700),
            ),
          ),

          cardTheme: CardThemeData(
            color: const Color(0xFF2B1B17),
            margin: const EdgeInsets.all(10),
            elevation: 8,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF424242), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'MedievalSharp',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD700),
            ),
            titleMedium: TextStyle(
              fontFamily: 'MedievalSharp',
              fontSize: 24,
              color: Color(0xFFFFD700),
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Almendra',
              fontSize: 18,
              color: Color(0xFFF5E6BE),
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Almendra',
              fontSize: 16,
              color: Color(0xFFF5E6BE),
            ),
            labelLarge: TextStyle(
              fontFamily: 'Cinzel',
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD700),
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 81, 1, 1),
              foregroundColor: const Color(0xFFFFD700),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              textStyle: const TextStyle(
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF5E6BE).withValues(alpha: 0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFFFD700)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
            ),
            labelStyle: const TextStyle(
              fontFamily: 'Almendra',
              color: Color(0xFFF5E6BE),
            ),
            hintStyle: const TextStyle(
              fontFamily: 'Almendra',
              color: Color(0x99F5E6BE),
            ),
          ),
        ),
      ),
    ),
  );
}
