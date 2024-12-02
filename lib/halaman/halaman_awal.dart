import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/admin/navbar_admin.dart';
import 'package:quiz_app/halaman/dosen/navbar_dosen.dart';
import 'package:quiz_app/halaman/mahasiswa/navbar_mhs.dart';

class HalamanAwal extends StatefulWidget {
  const HalamanAwal({super.key});

  @override
  State<HalamanAwal> createState() => _HalamanDaftarQuizMHSState();
}

class _HalamanDaftarQuizMHSState extends State<HalamanAwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NavbarAdmin()));
            },
            child: Container(
              alignment: Alignment.center,
              width: 160.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0xFFE6E6FA),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 65.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NavbarDosen()));
            },
            child: Container(
              alignment: Alignment.center,
              width: 160.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0xFFE6E6FA),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                "Pengajar",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 65.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NavbarMahasiswa()));
            },
            child: Container(
              alignment: Alignment.center,
              width: 160.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0xFFE6E6FA),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                "Pelajar",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
