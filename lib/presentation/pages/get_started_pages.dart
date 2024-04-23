import 'package:flutter/material.dart';
import 'package:nft/presentation/pages/sign_up_page.dart';
import 'package:nft/presentation/widgets/button_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/logo_started.png')),
            // Title
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Belajar Budaya\nBermain Game Bersama',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFF0D1220),
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 36 / 26),
              ),
            ),
            // Subtitle
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Kamu akan belajar hal yang menyenangkan tentang budaya yang beraneka ragam',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 16, height: 26 / 16),
              ),
            ),
            //Action
            const Gap(50),
            ButtonWidget(
              text: 'Mulai Belajar Yuk!',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SignUpPage(),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
