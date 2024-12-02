import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/beranda_dosen.dart';
import 'package:quiz_app/halaman/halaman_dalam_pengembangan.dart';

class NavbarDosen extends StatefulWidget {
  const NavbarDosen({super.key});

  @override
  State<NavbarDosen> createState() => _NavbarDosenState();
}

class _NavbarDosenState extends State<NavbarDosen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaDosen(),
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
            Image.asset("assets/icon/profil-ic.png", width: 25.0)
          ]),
    );
  }
}
