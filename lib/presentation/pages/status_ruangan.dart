import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:btp/presentation/widgets/user_info_widget.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<Map<String, String>> _statuses = [];
  String _currentUserName = 'John Doe'; // Ganti dengan nama pengguna saat ini

  @override
  void initState() {
    super.initState();
    _fetchStatuses();
  }

  Future<void> _fetchStatuses() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/status-peminjaman'));

    if (response.statusCode == 200) {
      List<dynamic> fetchedStatuses = jsonDecode(response.body);

      List<Map<String, String>?> formattedStatuses = fetchedStatuses.map((status) {
        String message;
        if (status['status'] == 'Disetujui' && status['nama_peminjam'] == _currentUserName) {
          message = 'Ruangan Yang Anda Ajukan Sudah Disetujui~';
        } else if (status['status'] == 'Ditolak' && status['nama_peminjam'] == _currentUserName) {
          message = 'Ruangan Yang Anda Ajukan Sudah Ditolak~ Silahkan Ajukan Ulang!';
        } else {
          return null;
        }

        return {
          'sender': 'Admin',
          'message': message,
          'date': DateFormat('dd MMM yyyy, HH:mm').format(DateTime.parse(status['updated_at'])),
        };
      }).where((status) => status != null).toList();

      setState(() {
        _statuses = formattedStatuses.cast<Map<String, String>>();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data status peminjaman')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: const BottomNavigationWidget(selectedIndex: 2),
      child: Column(
        children: [
          const Gap(20),
          const UserInfoWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: _statuses.length,
                itemBuilder: (context, index) {
                  final status = _statuses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFED3C35),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(
                            status['message']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Pengirim: ${status['sender']}\n${status['date']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
