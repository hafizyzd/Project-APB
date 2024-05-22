import 'package:flutter/material.dart';
import 'package:nft/presentation/pages/dicover_page.dart';
import 'package:nft/presentation/pages/sign_up_page.dart';
import 'package:nft/presentation/widgets/button_widget.dart';
import 'package:nft/presentation/widgets/input_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';


class StatusRuangan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Admin'),
      ),
      body: Center(
        child: const Text('This is the Chat Admin Page'),
      ),
    );
  }
}
