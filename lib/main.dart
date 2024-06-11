import 'package:flutter/material.dart';
import 'package:btp/presentation/pages/discover_page.dart';
import 'package:btp/presentation/pages/get_started_pages.dart';
import 'package:btp/presentation/pages/sign_in_page.dart';
import 'package:btp/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTP App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const GetStartedWrapper(),
    );
  }
}

class GetStartedWrapper extends StatefulWidget {
  const GetStartedWrapper({super.key});

  @override
  _GetStartedWrapperState createState() => _GetStartedWrapperState();
}

class _GetStartedWrapperState extends State<GetStartedWrapper> {
  Future<bool> _checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return true;
    } else {
      await prefs.setBool('seen', true);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkFirstSeen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == false) {
            return const GetStartedPage();
          } else {
            return const AuthWrapper();
          }
        }
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ApiService().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data != null) {
            return const DiscoverPage();
          } else {
            return const SignInPage();
          }
        }
      },
    );
  }
}
