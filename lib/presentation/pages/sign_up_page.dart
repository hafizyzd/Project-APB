import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:btp/presentation/pages/discover_page.dart';
import 'package:btp/presentation/pages/sign_in_page.dart';
import 'package:btp/presentation/widgets/button_widget.dart';
import 'package:btp/presentation/widgets/input_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:btp/services/api_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

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
                              InputWidget(
                                label: 'Nama Lengkap',
                                controller: nameController,
                              ),
                              InputWidget(
                                label: 'Username',
                                controller: usernameController,
                              ),
                              InputWidget(
                                label: 'Email',
                                controller: emailController,
                              ),
                              InputWidget(
                                label: 'Password',
                                controller: passwordController,
                                isPassword: true,
                              ),
                              const Gap(30),
                              Builder(builder: (context) {
                                return ButtonWidget(
                                  text: 'Daftar',
                                  isFullWidth: true,
                                  onPressed: () async {
                                    try {
                                      await apiService.signUp(
                                        nameController.text,
                                        usernameController.text,
                                        emailController.text,
                                        passwordController.text,
                                      );
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => const DiscoverPage(),
                                      ));
                                    } catch (e) {
                                      // Handle error
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Failed to sign up or login')),
                                      );
                                    }
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
