import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/halaman_dalam_pengembangan.dart';
import 'package:quiz_app/pages/mahasiswa/beranda_mhs.dart';

class NavbarMahasiswa extends StatefulWidget {
  const NavbarMahasiswa({super.key});

  @override
  State<NavbarMahasiswa> createState() => _NavbarMHSState();
}

class _NavbarMHSState extends State<NavbarMahasiswa> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaMahasiswa(),
    HalamanDalamPengembangan(),
    HalamanDalamPengembangan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color(0xFFE6E6FA),
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            Image.asset("assets/icon/home-ic.png", width: 25.0),
            Image.asset("assets/icon/announcement-ic.png", width: 25.0),
            Image.asset("assets/icon/profil-ic.png", width: 25.0)
          ]),
    );
  }
}
