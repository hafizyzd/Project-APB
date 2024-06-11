import 'package:flutter/material.dart';
import 'package:btp/presentation/pages/discover_page.dart';
import 'package:btp/presentation/pages/form_page.dart';
import 'package:btp/presentation/pages/account_page.dart';
import 'package:btp/presentation/pages/status_ruangan.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;

  const BottomNavigationWidget({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_add_check_circle_rounded, size: 26),
          label: 'Ruangan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet_rounded, size: 26),
          label: 'Form',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle, size: 26),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, size: 26),
          label: 'Akun',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFFED3C35),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed, // Menambahkan properti ini
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DiscoverPage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FormPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => StatusPage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AccountPage()),
            );
            break;
        }
      },
    );
  }
}
