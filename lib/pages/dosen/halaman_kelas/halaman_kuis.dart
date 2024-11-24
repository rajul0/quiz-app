import 'package:flutter/material.dart';

class HalamanKuis extends StatefulWidget {
  final String namaKuis;
  const HalamanKuis({Key? key, required this.namaKuis}) : super(key: key);

  @override
  State<HalamanKuis> createState() => _HalamanKuisState();
}

class _HalamanKuisState extends State<HalamanKuis> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 67.0,
            horizontal: 37.0,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 25.0,
                    icon: Icon(
                      Icons.arrow_back,
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.namaKuis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Pertanyaan Masih Kosong, Tambahkan Pertanyaan",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Cari pertanyaan',
            icon: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            label: 'Buat pertanyaan',
            icon: SizedBox.shrink(),
          ),
        ],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
