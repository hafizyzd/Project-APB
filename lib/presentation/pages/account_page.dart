import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:btp/presentation/pages/sign_in_page.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:btp/services/api_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final int _selectedIndex = 3;
  final ApiService apiService = ApiService();
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = apiService.getUserData();
  }

  Future<void> _signOut(BuildContext context) async {
    await apiService.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data found'));
        } else {
          final userData = snapshot.data!;
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
                              userData['nama_lengkap'] ?? 'No Name',
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              userData['email'] ?? 'No Email',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              'Role: ${userData['role'] ?? 'No Role'}',
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
                    leading: const Icon(Icons.logout_rounded, color: Color(0xFF0D1220)),
                    title: const Text(
                      'Sign Out',
                      style: TextStyle(color: Color(0xFF0D1220)),
                    ),
                    onTap: () async {
                      await _signOut(context);
                    },
                  ),
                  const Divider(color: Color(0xFF0D1220)),
                  const Gap(20),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
