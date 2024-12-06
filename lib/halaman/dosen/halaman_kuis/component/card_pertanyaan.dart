import 'package:flutter/material.dart';

Widget buildCardPertanyaan(
  BuildContext context,
  String pertanyaan, // Teks pertanyaan
  bool showDelete, // Apakah tombol delete ditampilkan
  VoidCallback onPressed, // Fungsi yang dipanggil saat tombol ditekan
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ikon pertanyaan
        Icon(
          Icons.question_answer,
          color: Colors.blueAccent,
          size: 32.0,
        ),
        const SizedBox(width: 12.0),

        // Teks pertanyaan
        Expanded(
          child: Text(
            pertanyaan,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Tombol hapus
        if (showDelete)
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: onPressed,
          ),
      ],
    ),
  );
}
