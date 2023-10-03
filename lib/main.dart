import 'package:budget/firestore.dart';
import 'package:budget/pages/pages.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import 'models/transactionmodel.dart';

// backgrounMessageHandler(SmsMessage message) async {
  // if (message.address!.contains('BW-SBIUPI')) {
  //   final regexp = RegExp(
  //       r'Dear UPI user A\/C x9786 debited by (\d.*\.\d.*) on date (\d{2}\w{3}\d{2}) trf to (\w.*) Refno (\d.*). if not u\? call 1800111109. -SBI');
  //   final match = regexp.firstMatch(message.body.toString());
  //   if (match!.groupCount != 0) {
  //     print(match.group(0).toString());
  //     print(match.group(1).toString());
  //     print(match.group(2).toString());
  //     print(match.group(3).toString());
  //     Firestore.createTransaction(
  //       TransactionModel(
  //         name: "Dummy",
  //         amount: match.group(1).toString(),
  //         type: "Dummy",
  //         category: "Dummy",
  //         date: match.group(2).toString(),
  //         notes: match.group(3).toString(),
  //       ),
  //     );
  //   }
  // } else {
  //   const SnackBar(content: Text("error"));
  // }
// }

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
