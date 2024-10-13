import 'package:flutter/material.dart';
import 'package:quiz_app/pages/halaman_awal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE6E6FA)),
        useMaterial3: true,
      ),
      home: HalamanAwal(),
    );
  }
}
