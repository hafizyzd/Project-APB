import 'package:flutter/material.dart';
import 'package:nft/presentation/pages/sign_in_page.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to SignInPage after 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ));
    });

    return PageWidget(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 450,
              child: Image.asset('assets/images/new-logo-2.png')),
            // Title
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Bandung Techno Park',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFF0D1220),
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 36 / 26),
              ),
            ),
            // Subtitle
            const Gap(0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Kamu bisa meminjam ruangan dengan cepat dan mudah untuk berbagai keperluan di Bandung Techno Park.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 16, height: 26 / 16),
              ),
            ),
            //Action
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
