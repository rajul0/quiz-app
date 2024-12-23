import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/card_pertanyaan.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_essai.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_ganda.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_isian_singkat.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_daftar_kuis.dart';
import 'package:quiz_app/halaman/dosen/navbar_dosen.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanKuis extends StatefulWidget {
  final String idKuis;
  final String namaKuis;
  const HalamanKuis({Key? key, required this.idKuis, required this.namaKuis})
      : super(key: key);

  @override
  State<HalamanKuis> createState() => _HalamanKuisState();
}

class _HalamanKuisState extends State<HalamanKuis> {
  late Future<Map> dataKuis;
  bool hasQuestions = true;

  DateTime? startTime;
  DateTime? endTime;
  bool? _quizAvailable;

  @override
  void initState() {
    super.initState();
    dataKuis = fetchDataKuis(widget.idKuis);
  }

  Future<Map> fetchDataKuis(String idKuis) async {
    final response = await getQuizById(idKuis);
    setState(() {
      hasQuestions = response["daftar_pertanyaan"] != null;
    });

    return response;
  }

  void _hapusKuis() {
    hapusKuis(widget.idKuis);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NavbarDosen()),
      (route) => false,
    );
  }

  Future _showBackDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Kuis harus memiliki minimal 1 pertanyaan, buat pertanyaan?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _hapusKuis();
            },
            child: Text(
              'Hapus',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Tambah pertanyaan",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context,
      {required TimeOfDay initialTime}) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (selectedTime != null) {
        String formattedTime =
            '${selectedTime.format(context)}'; // Formatted time as "HH:mm"
        String formattedDate =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'; // Formatted date as "dd/MM/yyyy"

        print(
            'Waktu mulai: $formattedTime pada $formattedDate'); // Output to console for testing

        return DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      }
    }

    return null;
  }

  void _startQuiz() async {
    Navigator.pop(context);

    if (hasQuestions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 10.0,
          content: Text(
            'Atur waktu mulai kuis',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
        ),
      );

      // Pilih waktu mulai
      startTime = await _selectDateTime(context, initialTime: TimeOfDay.now());

      if (startTime != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Atur waktu akhir kuis',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
          ),
        );

        // Pilih waktu akhir
        endTime = await _selectDateTime(context, initialTime: TimeOfDay.now());

        if (endTime != null) {
          // Tampilkan loading
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );

          try {
            // Memperbarui waktu kuis
            await updateQuizTime(widget.idKuis, startTime!, endTime!);

            // Perbarui state setelah berhasil
            setState(() {
              _quizAvailable = true;
            });

            // Tutup loading dialog
            Navigator.pop(context);
            dataKuis = fetchDataKuis(widget.idKuis);

            // Tampilkan notifikasi sukses
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Kuis berhasil dimulai."),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          } catch (error) {
            // Tutup loading dialog jika terjadi error
            Navigator.pop(context);

            // Tampilkan notifikasi error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Gagal memulai kuis: $error"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      }
    } else {
      // Tampilkan dialog jika tidak ada pertanyaan
      _showBackDialog();
    }
  }

  Future _aturWaktuKuis() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Atur waktu pengerjaan kuis sebelum memulai',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _startQuiz,
            child: Text(
              'Atur',
              style: TextStyle(
                color: Colors.green,
                fontSize: 14.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Atur nanti",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _batalkanKuis() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Batalkan kuis?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Tampilkan loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              );

              try {
                // Panggil fungsi untuk menghapus waktu kuis
                await deleteQuizTime(widget.idKuis);

                setState(() {
                  _quizAvailable = false;
                });

                // Tutup loading dan dialog konfirmasi
                Navigator.pop(context); // Tutup loading
                Navigator.pop(context); // Tutup dialog konfirmasi

                // Tampilkan notifikasi sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Waktu kuis berhasil dihapus."),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );

                // Perbarui data halaman jika diperlukan
                dataKuis = fetchDataKuis(widget.idKuis);
              } catch (error) {
                // Tutup loading
                Navigator.pop(context);

                // Tampilkan notifikasi error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Gagal menghapus waktu kuis: $error"),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text(
              "Iya",
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Lanjutkan kuis',
              style: TextStyle(
                color: Colors.green,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String isoDate) {
    final DateTime dateTime = DateTime.parse(isoDate);
    final DateFormat formatter = DateFormat('d MMMM yyyy, HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final double tinggiLayar = MediaQuery.of(context).size.height;
    return FutureBuilder<Map>(
        future: dataKuis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var dataKuis = snapshot.data?["daftar_pertanyaan"];
          String waktuMulai = '';
          String waktuBerakhir = '';

          if (snapshot.data?["start_time"] != null) {
            waktuMulai = formatDateTime(snapshot.data?["start_time"]);
            waktuBerakhir = formatDateTime(snapshot.data?["end_time"]);
            _quizAvailable = true;
          } else {
            _quizAvailable = false;
          }

          return PopScope(
            canPop: hasQuestions,
            onPopInvoked: (didPop) async {
              if (didPop) return;

              final shouldPop = await _showBackDialog() ?? false;
              if (context.mounted && shouldPop) {
                Navigator.pop(context);
              }
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 67.0,
                    horizontal: 10.0,
                  ),
                  child: Container(
                    height: tinggiLayar,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: hasQuestions
                                        ? () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HalamanDaftarKuis(),
                                                ),
                                                (route) => false);
                                          }
                                        : () async {
                                            final shouldPop =
                                                await _showBackDialog() ??
                                                    false;
                                            if (context.mounted && shouldPop) {
                                              Navigator.pop(context);
                                            }
                                          })),
                            SizedBox(
                              width: 15.0,
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
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Kuis dimulai pada: $waktuMulai",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Kuis berakhir pada: $waktuBerakhir",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Divider(
                          thickness: 2.0,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        // Menampilkan teks
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Text(
                                "Kode Kuis: ${widget.idKuis}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 10),
                              // Tombol salin ke clipboard
                              ElevatedButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(
                                            ClipboardData(text: widget.idKuis))
                                        .then((_) {
                                      // Menampilkan snackbar sebagai notifikasi
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Teks berhasil disalin ke clipboard!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    });
                                  },
                                  label: Icon(
                                    Icons.copy,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          flex: 0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: hasQuestions
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ListView.builder(
                                      shrinkWrap: true, // Tambahkan ini
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: dataKuis!.length,
                                      itemBuilder: (context, index) {
                                        final pertanyaan = dataKuis[index];
                                        return buildCardPertanyaan(
                                          context,
                                          pertanyaan["pertanyaan"],
                                          false,
                                          () {
                                            print("pertanyaan dihapus");
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "Pertanyaan Masih Kosong, Tambahkan Pertanyaan",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        _quizAvailable!
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: Offset(0, 2), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .transparent, // Transparent untuk Decoration
                                      shadowColor: Colors
                                          .transparent, // Hilangkan shadow default
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _batalkanKuis();
                                      });
                                    },
                                    child: SizedBox(
                                      width: 150.0,
                                      height: 30.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Batalkan kuis",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: Offset(0, 2), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .transparent, // Transparent untuk Decoration
                                      shadowColor: Colors
                                          .transparent, // Hilangkan shadow default
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                    ),
                                    onPressed: _aturWaktuKuis,
                                    child: SizedBox(
                                      width: 150.0,
                                      height: 30.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Mulai kuis",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled:
                        true, // Mengizinkan kontrol tinggi popup
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 0.5, // Setengah layar
                        minChildSize: 0.25, // Tinggi minimal
                        maxChildSize: 0.8, // Tinggi maksimal
                        expand: false,
                        builder: (context, scrollController) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            child: ListView(
                              controller:
                                  scrollController, // Scroll untuk isi popup
                              children: [
                                Text(
                                  'Pilih Jenis Pertanyaan',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 30.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HalamanBuatPertanyaanGanda(
                                          idKuis: widget.idKuis,
                                          namaKuis: widget.namaKuis,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Pilihan ganda',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HalamanBuatPertanyaanIsianSingkat(
                                          idKuis: widget.idKuis,
                                          namaKuis: widget.namaKuis,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Isian singkat',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HalamanBuatPertanyaanEssai(
                                          idKuis: widget.idKuis,
                                          namaKuis: widget.namaKuis,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Essai',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                label: Text(
                  'Tambah Pertanyaan',
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ), // Teks tambahan
                icon: Icon(
                  Icons.add,
                  color: Colors.black.withOpacity(0.5),
                ), // Ikon di sebelah teks
                backgroundColor: Colors.white,
              ),
            ),
          );
        });
  }
}
