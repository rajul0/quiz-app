import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kelas/halaman_manajemen_kelas.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_daftar_kuis.dart';
import 'package:quiz_app/halaman/dosen/navbar_dosen.dart';
import 'package:quiz_app/halaman/halaman_awal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // supportedLocales: [Locale('id', 'ID')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE6E6FA)),
        useMaterial3: true,
      ),
      home: HalamanAwal(),
      routes: {
        '/beranda-dosen': (context) => NavbarDosen(),
        '/halaman-manajemen-kelas': (context) => HalamanManajemenKelasDosen(),
        '/halaman-daftar-kuis': (context) => HalamanDaftarKuis()
      },
    );
  }
}
