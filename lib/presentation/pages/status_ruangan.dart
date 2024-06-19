import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:btp/presentation/widgets/user_info_widget.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<Map<String, String>> _statuses = []; // Store the statuses here

  Future<void> _fetchStatuses() async {
    final prefs = await SharedPreferences.getInstance();
    final _currentUserId = prefs.getInt('user_id');

    if (_currentUserId == null) {
      throw Exception('User ID not found');
    }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/status-peminjaman'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id_users': _currentUserId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<dynamic> fetchedStatuses = responseBody['statuses'];

      List<String>? removedStatuses = prefs.getStringList('removed_statuses') ?? [];
      Map<String, String>? statusTimestamps = prefs.getStringMap('status_timestamps') ?? {};

      setState(() {
        _statuses = fetchedStatuses.map<Map<String, String>>((status) {
          String message = 'Status Error~';

          if (status['status'] == "Disetujui") {
            message = 'Ruangan Yang Anda Ajukan Sudah Disetujui~';
          } else if (status['status'] == "Ditolak") {
            message = 'Ruangan Yang Anda Ajukan Sudah Ditolak~ Silahkan Ajukan Ulang!';
          } else if (status['status'] == "Menunggu") {
            message = 'Ruangan Yang Anda Ajukan Sedang Direview Oleh Admin. Tunggu Informasi Lebih Lanjut Ya~';
          }

          DateTime updatedAtUtc = DateTime.parse(status['updated_at']);
          DateTime updatedAtLocal = updatedAtUtc.toLocal();
          String updatedAtString = updatedAtLocal.toIso8601String();

          if (removedStatuses.contains(status['id_ruangan'].toString()) && statusTimestamps[status['id_ruangan'].toString()] == updatedAtString) {
            return {}; // Skip removed statuses that have not changed
          }

          return {
            'id': status['id_ruangan'].toString(),
            'sender': status['nama_ruangan'],
            'message': message,
            'date': DateFormat('dd MMM yyyy, HH:mm').format(updatedAtLocal),
            'updated_at': updatedAtString
          };
        }).where((status) => status.isNotEmpty).toList();
      });
    } else {
      throw Exception('Failed to load statuses');
    }
  }

  void _removeStatus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? removedStatuses = prefs.getStringList('removed_statuses') ?? [];
    Map<String, String>? statusTimestamps = prefs.getStringMap('status_timestamps') ?? {};

    setState(() {
      removedStatuses.add(_statuses[index]['id']!);
      statusTimestamps[_statuses[index]['id']!] = _statuses[index]['updated_at']!;
      _statuses.removeAt(index);
    });

    await prefs.setStringList('removed_statuses', removedStatuses);
    await prefs.setStringMap('status_timestamps', statusTimestamps);
  }

  @override
  void initState() {
    super.initState();
    _fetchStatuses();
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
            child: _statuses.isEmpty
                ? const Center(child: Text('Tidak Ada Notifikasi Status Peminjaman!'))
                : Padding(
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
                                  'Ruangan: ${status['sender']}\n${status['date']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  onPressed: () => _removeStatus(index),
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

extension SharedPreferencesExtension on SharedPreferences {
  Future<bool> setStringMap(String key, Map<String, String> value) {
    return setString(key, json.encode(value));
  }

  Map<String, String>? getStringMap(String key) {
    String? jsonString = getString(key);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap.map((k, v) => MapEntry(k, v.toString()));
    }
    return null;
  }
}
