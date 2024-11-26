import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/admin/beranda_admin.dart';
import 'package:quiz_app/halaman/halaman_dalam_pengembangan.dart';

class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({super.key});

  @override
  State<NavbarAdmin> createState() => _BerandaMahasiswaState();
}

class _BerandaMahasiswaState extends State<NavbarAdmin> {
  // ignore: unused_field
  String _searchKeyword = "";

  // ignore: unused_field
  String _errorMessage = '';
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HalamanBerandaAdmin(),
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
            Image.asset("assets/icon/manage-people-ic.png", width: 35.0),
            Image.asset("assets/icon/profil-ic.png", width: 25.0)
          ]),
    );
  }
}
