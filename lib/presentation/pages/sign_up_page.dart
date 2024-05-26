import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/presentation/pages/dicover_page.dart';
import 'package:nft/presentation/pages/sign_in_page.dart';
import 'package:nft/presentation/widgets/button_widget.dart';
import 'package:nft/presentation/widgets/input_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Gap(60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Daftar Akun Untuk Peminjaman Ruangan Bandung Techno Park',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF0D1220),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 36 / 26,
                            ),
                          ),
                        ),
                        const Gap(40),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              const InputWidget(
                                lable: 'Nama Lengkap',
                              ),
                              const InputWidget(
                                lable: 'Email',
                              ),
                              const InputWidget(
                                lable: 'Password',
                                isPassword: true,
                              ),
                              const Gap(10),
                              Builder(builder: (context) {
                                return ButtonWidget(
                                  text: 'Daftar',
                                  isFullWidth: true,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => const DiscoverPage(),
                                    ));
                                  },
                                );
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ));
                      },
                      child: Text(
                        'Sign In to My Account',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF909FB4),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
