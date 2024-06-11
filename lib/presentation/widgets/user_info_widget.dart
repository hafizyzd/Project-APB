import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:btp/constants/color_constant.dart';
import 'package:btp/services/api_service.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  final ApiService apiService = ApiService();
  late Future<Map<String, String?>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = apiService.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorConstant.primary),
                          borderRadius: BorderRadius.circular(60 / 2)),
                      child: Image.asset('assets/images/User1.png'),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['nama_lengkap'] ?? 'No Name',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color(0xFF0D1220)),
                        ),
                        const Gap(6),
                        Text(
                          userData['role'] ?? 'No Role',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 48, 52, 59)),
                        ),
                      ],
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/svgs/notification.svg'),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
