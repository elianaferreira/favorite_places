import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0XFFC780FA),
    background: const Color(0XFF643A6B));

final theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
        bodyLarge: GoogleFonts.ubuntuCondensed(color: colorScheme.onBackground),
        bodyMedium:
            GoogleFonts.ubuntuCondensed(color: colorScheme.onBackground),
        bodySmall: GoogleFonts.ubuntuCondensed(color: colorScheme.onBackground),
        titleSmall: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold, color: colorScheme.onBackground),
        titleMedium: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold, color: colorScheme.onBackground),
        titleLarge: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold, color: colorScheme.onBackground)));

Future main() async {
  await dotenv.load(fileName: 'lib/.env');
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Places',
      theme: theme,
      home: const PlacesScreen(),
    );
  }
}
