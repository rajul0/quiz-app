import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/class_kuis.dart';

final apiUrl = dotenv.env['API_URL'] ?? 'Default API URL';
final apiKey = dotenv.env['API_KEY'] ?? 'Default API Key';

Future<List<Quiz>> daftarSemuaKuis() async {
  final response = await http.get(Uri.parse('$apiUrl/api/kuis'));
  print(response);
  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    return data.map((quiz) => Quiz.fromJson(quiz)).toList();
  } else {
    throw Exception('Failed to load quizzes');
  }
}

Future buatKuis(String namaKuis) async {
  if (namaKuis.isNotEmpty) {
    try {
      final url = Uri.parse('$apiUrl/api/kuis/buatKuis'); // Endpoint API
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'nama': namaKuis,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data successfully added: ${data['id']}');
        return data; // ID kuis dari response
      } else {
        print('Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  } else {
    print('Please fill all fields.');
    return null;
  }
}

Future<bool> hapusKuis(String idKuis) async {
  if (idKuis.isNotEmpty) {
    try {
      final url =
          Uri.parse('$apiUrl/api/kuis/hapusKuis/$idKuis'); // Endpoint API
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Kuis successfully deleted.');
        return true;
      } else {
        print('Error: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  } else {
    print('ID kuis tidak boleh kosong.');
    return false;
  }
}

Future<Map> daftarPertanyaaKuis(String idKuis) async {
  final String url = '$apiUrl/api/kuis/$idKuis/pertanyaan';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final Map data = json.decode(response.body);
    print(data);
    return data;
  } else {
    throw Exception('Failed to load quizzes');
  }
}

Future<void> tambahPertanyaan(
    String idKuis, List<Map<String, dynamic>> data) async {
  final String url = '$apiUrl/api/kuis/$idKuis/tambahPertanyaan';

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'daftar_pertanyaan': data,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Pertanyaan berhasil ditambahkan: ${responseData['kuis']}');
    } else {
      print(
          'Gagal menambahkan pertanyaan: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
