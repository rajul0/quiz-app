import 'package:flutter/material.dart';

class HalamanHasilQuizMHS extends StatefulWidget {
  const HalamanHasilQuizMHS({super.key});

  @override
  State<HalamanHasilQuizMHS> createState() => _HalamanDaftarQuizMHSState();
}

class _HalamanDaftarQuizMHSState extends State<HalamanHasilQuizMHS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 67.0, horizontal: 37.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "Hasil Kuis",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter",
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 90.0,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              width: 160.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0xFFE6E6FA),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_graph_outlined,
                    size: 28.0,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "Grafik Hasil",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 65.0,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: 160.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0xFFE6E6FA),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.feedback,
                    size: 28.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Umpan Balik",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
