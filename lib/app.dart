import 'package:flutter/material.dart';
import 'package:wikigen/home/view/home_page.dart';
import 'package:dynamic_color/dynamic_color.dart';

const _brandBlue = Color(0xFF1E88E5);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          // On Android S+ devices, use the provided dynamic color scheme.
          // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
          lightColorScheme = lightDynamic.harmonized();
          // (Optional) If applicable, harmonize custom colors.

          // Repeat for the dark color scheme.
          darkColorScheme = darkDynamic.harmonized();
// ignore, only for demo purposes
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
          ),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
