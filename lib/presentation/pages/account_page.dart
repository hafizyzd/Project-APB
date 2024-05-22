import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:nft/presentation/pages/dicover_page.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatelessWidget {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
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
                    decoration: BoxDecoration(
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
                        'John Doe',
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
                        'Role: Admin',
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
            const Gap(40),
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
                // Perform logout action
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
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_add_check_circle_rounded, size: 26, color: Color(0xFFED3C35)),
          label: 'Ruangan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet_rounded, size: 26, color: Color(0xFFED3C35)),
          label: 'Form',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle, size: 26, color: Color(0xFFED3C35)),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, size: 26, color: Color(0xFFED3C35)),
          label: 'Akun',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFFED3C35), // Selected icon and label color
      unselectedItemColor: Colors.grey, // Unselected icon and label color
      showSelectedLabels: true, // Show labels for selected items
      showUnselectedLabels: true, // Show labels for unselected items
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscoverPage()),
            );
            break;
          case 1:
            // Navigasi ke halaman Form Peminjaman
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => FormPage()),
            // );
            break;
          case 2:
            // Navigasi ke halaman Status Ruangan
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => StatusPage()),
            // );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
            break;
        }
      },
    );
  }
}
