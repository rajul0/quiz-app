import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/class_kuis.dart';

import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_hasil_per_kuis.dart';

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

Future<Map<String, dynamic>> getQuizById(idKuis) async {
  final response = await http.get(Uri.parse('$apiUrl/api/kuis/$idKuis'));
  print(response.body);
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load quizzes');
  }
}

// Future<Map<String, dynamic>> getAvailableQuizById(id) async {
//   try {
//     final response =
//         await http.get(Uri.parse('$apiUrl/api/kuis/available/$id'));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> quiz = json.decode(response.body);
//       return quiz;
//     } else {
//       throw Exception('Failed to load available quiz');
//     }
//   } catch (error) {
//     throw Exception('Failed to load available quiz: $error');
//   }
// }

Future<Map<String, dynamic>> getAvailableQuizById(idKuis) async {
  final response = await http.get(Uri.parse('$apiUrl/api/kuis/$idKuis'));
  print(response.body);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['start_time'] != null && data['end_time'] != null) {
      return data;
    } else {
      throw Exception('Quiz start or end time is null');
    }
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

Future<void> updateQuizTime(
    idKuis, DateTime startTime, DateTime endTime) async {
  try {
    // Format waktu menjadi string yang sesuai dengan format database
    String startTimeFormatted =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime);
    String endTimeFormatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime);

    // Kirim request ke API
    final response = await http.put(
      Uri.parse('$apiUrl/api/kuis/$idKuis/update-time'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'start_time': startTimeFormatted,
        'end_time': endTimeFormatted,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle success, misalnya dengan menunjukkan pesan sukses pada UI
      print(data);
    } else {
      // Handle error
      print('Failed to update quiz time');
    }
  } catch (error) {
    print('Error: $error');
  }
}

Future<void> deleteQuizTime(String idKuis) async {
  try {
    // Kirim permintaan DELETE ke API
    final response = await http.delete(
      Uri.parse('$apiUrl/api/kuis/$idKuis/delete-time'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle sukses, misalnya dengan menunjukkan pesan sukses pada UI
      print('Quiz time deleted successfully: $data');
    } else {
      // Handle error
      print('Failed to delete quiz time: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

// Riwayat Kuis
// -------------------------------------------------------- //
Future<void> simpanRiwayatKuis(int idKuis, int idUser, int nilai) async {
  final String url = '$apiUrl/api/riwayat-kuis/simpanRiwayat';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'id_kuis': idKuis,
        'id_user': idUser,
        'nilai': nilai,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('Riwayat kuis berhasil disimpan: ${responseData['message']}');
    } else {
      print(
          'Gagal menyimpan riwayat kuis: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<List<Map<String, dynamic>>?> getQuizHistory(
    int idKuis, int idUser) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/riwayat-kuis/kuis-user'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'id_kuis': idKuis,
      'id_user': idUser,
    }),
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(json.decode(response.body));
    // Sort the data by 'attempt_date' in descending order
    data.sort((a, b) {
      final DateTime dateA = DateTime.parse(a['attempt_date']);
      final DateTime dateB = DateTime.parse(b['attempt_date']);
      return dateB
          .compareTo(dateA); // Reverse the comparison for descending order
    });
    print(data);
    return data;
  } else {
    return null;
  }
}

Future<List<QuizHistory>> fetchQuizHistoryById(int idKuis) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/riwayat-kuis/by-kuis'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'id_kuis': idKuis}),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => QuizHistory.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load quiz history');
  }
}

Future<Map<int, Map<String, dynamic>>> fetchGroupedQuizHistory(
    int idKuis) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/riwayat-kuis/by-kuis'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'id_kuis': idKuis}),
  );

  if (response.statusCode == 200) {
    try {
      final List<dynamic> data = jsonDecode(response.body);
      final List<QuizAttempt> attempts =
          data.map((e) => QuizAttempt.fromJson(e)).toList();

      // Kelompokkan berdasarkan id_user
      final Map<int, Map<String, dynamic>> groupedData = {};
      for (var attempt in attempts) {
        if (!groupedData.containsKey(attempt.idUser)) {
          groupedData[attempt.idUser] = {
            'idUser': attempt.idUser,
            'nilaiTerakhir': attempt.nilai,
            'tanggalTerakhir': attempt.attemptDate,
            'totalAttempt': 1,
          };
        } else {
          groupedData[attempt.idUser]!['nilaiTerakhir'] = attempt.nilai;
          groupedData[attempt.idUser]!['tanggalTerakhir'] = attempt.attemptDate;
          groupedData[attempt.idUser]!['totalAttempt'] += 1;
        }
      }

      return groupedData;
    } catch (error) {
      print(error);
      final Map<int, Map<String, dynamic>> groupedData = {};

      return groupedData;
    }
  } else {
    final Map<int, Map<String, dynamic>> groupedData = {};

    return groupedData;

    // throw Exception('Failed to load quiz history');
  }
}

Future<List<Map<String, dynamic>>> getQuizHistoryByUser(int idUser) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/riwayat-kuis/by-user'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'id_user': idUser,
    }),
  );
  print(response.body);

  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    // Extract only the id_kuis for each attempt
    List<dynamic> quizIds = data.map((quiz) => quiz['id_kuis']).toList();

    // Use a Set to ensure unique quiz IDs
    Set<dynamic> uniqueQuizIds = quizIds.toSet();

    // Fetch quiz details for unique ids only
    List<Future<Map<String, dynamic>>> quizDetailsFutures =
        uniqueQuizIds.map((idKuis) => getQuizById(idKuis)).toList();

    // Wait for all futures to complete and return them
    return Future.wait(quizDetailsFutures);
  } else {
    throw Exception('Failed to load quizzes');
  }
}

Future<List<QuizHistoryByid>> fetchQuizHistory(int idKuis, int idUser) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/riwayat-kuis/kuis-user'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'id_kuis': idKuis,
      'id_user': idUser,
    }),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    // Sort the data based on 'attempt_date' in descending order
    data.sort((a, b) => DateTime.parse(b['attempt_date'])
        .compareTo(DateTime.parse(a['attempt_date'])));
    return data.map((e) => QuizHistoryByid.fromJson(e)).toList();
  } else if (response.statusCode == 404) {
    throw Exception('Belum pernah mengikuti kuis ini.');
  } else {
    throw Exception('Gagal mengambil riwayat kuis.');
  }
}
