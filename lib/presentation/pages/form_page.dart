import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/button_widget.dart';
import 'package:btp/presentation/widgets/user_info_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final int _selectedIndex = 1;
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDateTime;
  DateTime? _endDateTime;

  final TextEditingController _namaPeminjamController = TextEditingController();
  final TextEditingController _jumlahPesertaController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _startDateTimeController = TextEditingController();
  final TextEditingController _endDateTimeController = TextEditingController();

  String? _selectedRuangan;
  String _status = 'Pending';

  List<dynamic> _ruanganList = [];
  int? _userId;

  @override
  void initState() {
    super.initState();
    _fetchRuangan();
    _fetchUserId();
  }

  Future<void> _fetchRuangan() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/ruangan'));

    if (response.statusCode == 200) {
      setState(() {
        _ruanganList = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data ruangan')),
      );
    }
  }

  Future<void> _fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('user_id');
    });
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartDateTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStartDateTime) {
            _startDateTime = pickedDateTime;
            _startDateTimeController.text = _formatDateTime(pickedDateTime);
          } else {
            _endDateTime = pickedDateTime;
            _endDateTimeController.text = _formatDateTime(pickedDateTime);
          }
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _updateLokasiDanHarga(String? selectedRuangan) {
    final ruangan = _ruanganList.firstWhere((r) => r['id_ruangan'].toString() == selectedRuangan);
    _lokasiController.text = ruangan['lokasi'];
    _hargaController.text = formatHarga(int.parse(ruangan['harga_ruangan']));
  }

  String formatHarga(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    )}';
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/peminjaman'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama_peminjam': _namaPeminjamController.text,
          'id_ruangan': int.parse(_selectedRuangan!),
          'id_users': _userId,
          'tanggal_mulai': '${_startDateTime!.year}-${_startDateTime!.month.toString().padLeft(2, '0')}-${_startDateTime!.day.toString().padLeft(2, '0')} ${_startDateTime!.hour.toString().padLeft(2, '0')}:${_startDateTime!.minute.toString().padLeft(2, '0')}',
          'tanggal_selesai': '${_endDateTime!.year}-${_endDateTime!.month.toString().padLeft(2, '0')}-${_endDateTime!.day.toString().padLeft(2, '0')} ${_endDateTime!.hour.toString().padLeft(2, '0')}:${_endDateTime!.minute.toString().padLeft(2, '0')}',
          'jumlah': int.parse(_jumlahPesertaController.text),
          'status': _status,
          'keterangan': _catatanController.text,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pengajuan Berhasil Dikirim!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal Mengirim Pengajuan!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: BottomNavigationWidget(selectedIndex: _selectedIndex),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            const UserInfoWidget(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaPeminjamController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Peminjam',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Nama Peminjam!';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Ruangan',
                      ),
                      items: _ruanganList.map((ruangan) {
                        return DropdownMenuItem(
                          value: ruangan['id_ruangan'].toString(),
                          child: Text(ruangan['nama_ruangan']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRuangan = value as String?;
                          _updateLokasiDanHarga(_selectedRuangan);
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Masukkan ruangan anda!';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _lokasiController,
                      decoration: const InputDecoration(
                        labelText: 'Lokasi',
                      ),
                      enabled: false,
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _hargaController,
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                      ),
                      enabled: false,
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _jumlahPesertaController,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Peserta',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Jumlah Peserta!';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Mulai Peminjaman',
                      ),
                      controller: _startDateTimeController,
                      onTap: () => _selectDateTime(context, true),
                      readOnly: true,
                      validator: (value) {
                        if (_startDateTime == null) {
                          return 'Masukkan Mulai Peminjaman!';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Selesai Peminjaman',
                      ),
                      controller: _endDateTimeController,
                      onTap: () => _selectDateTime(context, false),
                      readOnly: true,
                      validator: (value) {
                        if (_endDateTime == null) {
                          return 'Masukkan Selesai Peminjaman!';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _catatanController,
                      decoration: const InputDecoration(
                        labelText: 'Catatan',
                      ),
                      maxLines: 4,
                    ),
                    const Gap(16),
                    ButtonWidget(
                      text: 'Kirim Pengajuan',
                      onPressed: _submitForm,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
