import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/class_kuis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HalamanEditKuis extends StatefulWidget {
  final Quiz quiz;

  HalamanEditKuis({required this.quiz});

  @override
  _HalamanEditKuisState createState() => _HalamanEditKuisState();
}

class _HalamanEditKuisState extends State<HalamanEditKuis> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.quiz.nama);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('https://your-api-url.com/api/quizzes/${widget.quiz.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': titleController.text,
          'description': descriptionController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan perubahan.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Kuis: ${widget.quiz.nama}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul Kuis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi Kuis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveChanges,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
