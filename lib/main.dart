import 'package:dnd_dice_roller/screens/dice_choice.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Color.fromARGB(255, 81, 9, 112),

  // Primary
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),

  // Secondary
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF2E2738),

  // Tertiary
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF4B1B2A),

  // Error
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),

  // Surface
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  onSurfaceVariant: Color(0xFF49454F),
  surfaceContainerHighest: Color(0xFFDAD2E0),

  // Outline & shadows
  outline: Color(0xFF79747E),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFF313033),
  onInverseSurface: Color(0xFFF4EFF4),
  inversePrimary: Color(0xFFD0BCFF),
  surfaceTint: Color(0xFF6750A4),
);

final ThemeData appTheme = ThemeData(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.surface,
);

void main() {
  runApp(
    MaterialApp(
      home: DiceChoice(),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          elevation: 2,
          centerTitle: true,
        ),

        // Card
        cardTheme: CardThemeData(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.all(10),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Text
        textTheme: TextTheme(
          // Titoli principali
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSurface,
          ),
          titleMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: kColorScheme.onSurface,
          ),
          titleSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: kColorScheme.onSurface,
          ),

          // Testo principale del corpo
          bodyLarge: TextStyle(
            fontSize: 16,
            color: kColorScheme.onSurface, 
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color:
                kColorScheme.onSurfaceVariant, 
          ),

          // Label, bottoni piccoli, caption
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kColorScheme.primary, 
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            color: kColorScheme.onSurfaceVariant,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: kColorScheme.onSurfaceVariant,
          ),
        ),

        // ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // OutlinedButton
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kColorScheme.primaryContainer,
            side: BorderSide(color: kColorScheme.primaryContainer),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // TextField / Input
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),

        // FloatingActionButton
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),

        // BottomNavigationBar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kColorScheme.surface,
          selectedItemColor: kColorScheme.primary,
          unselectedItemColor: kColorScheme.onSurfaceVariant,
        ),
      ),
    ),
  );
}
