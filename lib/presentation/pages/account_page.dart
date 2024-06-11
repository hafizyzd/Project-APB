import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:nft/presentation/widgets/bottom_navigation_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';

class AccountPage extends StatelessWidget {
  final int _selectedIndex = 3;

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: BottomNavigationWidget(selectedIndex: _selectedIndex),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFED3C35),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/User1.png'),
                    ),
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alex Somay',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        'john.doe@example.com',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        'Role: Penyewa',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        'Nama: Johnathan Doe',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(30),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF0D1220)),
              title: const Text(
                'Profile',
                style: TextStyle(color: Color(0xFF0D1220)),
              ),
              onTap: () {
                // Navigate to profile page
              },
            ),
            const Divider(color: Color(0xFF0D1220)),
            ListTile(
              leading: const Icon(Icons.person_search, color: Color(0xFF0D1220)),
              title: const Text(
                'Role Pengguna',
                style: TextStyle(color: Color(0xFF0D1220)),
              ),
              onTap: () {
                // Perform role pengguna action
              },
            ),
            const Divider(color: Color(0xFF0D1220)),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Color(0xFF0D1220)),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Color(0xFF0D1220)),
              ),
              onTap: () {
                // Perform logout action
              },
            ),
            const Divider(color: Color(0xFF0D1220)),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
