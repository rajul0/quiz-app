import 'package:flutter/material.dart';
import 'package:quiz_app/pages/admin/beranda_admin.dart';
import 'package:quiz_app/pages/dosen/beranda_dosen.dart';
import 'package:quiz_app/pages/mahasiswa/beranda_mhs.dart';

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
                  MaterialPageRoute(builder: (context) => BerandaAdmin()));
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
                  MaterialPageRoute(builder: (context) => BerandaDosen()));
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
                "Dosen",
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
                  MaterialPageRoute(builder: (context) => BerandaMahasiswa()));
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
                "Mahasiswa",
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
