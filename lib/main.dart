import 'package:budget/pages/pages.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expenses - Budget App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightDynamic,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: darkDynamic,
        ),
        // themeMode: Provider.of<ThemeProvider>(context).themeMode,
        themeMode: ThemeMode.system,
        home: const HomePage(),
      );
    });
  }
}
