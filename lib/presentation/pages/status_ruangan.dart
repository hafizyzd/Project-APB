import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft/presentation/widgets/user_info_widget.dart';
import 'package:nft/presentation/widgets/bottom_navigation_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';

class StatusPage extends StatelessWidget {
  StatusPage({super.key});

  final List<Map<String, String>> statuses = [
    {
      'sender': 'admin',
      'message': 'Halo! Semangat yah akhir semesternya',
      'date': '07 Mar 2024, 13:06'
    },
    {
      'sender': 'admin',
      'message': 'Ruangan yang anda ajukan sudah di setujui',
      'date': '05 Feb 2024, 11:43'
    },
    // Add more statuses as needed
  ];

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: const BottomNavigationWidget(selectedIndex: 2),
      child: Column(
        children: [
          const Gap(20),
          UserInfoWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  final status = statuses[index];
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
