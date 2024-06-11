import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/presentation/pages/discover_page.dart';
import 'package:nft/presentation/pages/sign_up_page.dart';
import 'package:nft/presentation/widgets/button_widget.dart';
import 'package:nft/presentation/widgets/input_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:nft/services/api_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                            'Mudah Peminjaman Ruangan',
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
                                label: 'Email',
                                controller: emailController,
                              ),
                              InputWidget(
                                label: 'Password',
                                controller: passwordController,
                                isPassword: true,
                              ),
                              const Gap(10),
                              Builder(builder: (context) {
                                return ButtonWidget(
                                  text: 'Sign In',
                                  isFullWidth: true,
                                  onPressed: () async {
                                    try {
                                      await apiService.login(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => const DiscoverPage(),
                                      ));
                                    } catch (e) {
                                      // Handle error
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Failed to login')),
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
                          builder: (context) => const SignUpPage(),
                        ));
                      },
                      child: Text(
                        'Create New Account',
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
