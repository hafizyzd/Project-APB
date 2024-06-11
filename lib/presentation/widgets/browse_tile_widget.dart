import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'button_widget.dart'; // Pastikan path ini benar
import 'package:btp/presentation/pages/detail_room.dart';

class Browse {
  final String image;
  final String title;
  final dynamic ruangan;

  Browse({required this.image, required this.title, required this.ruangan});
}

class BrowseTileWidget extends StatelessWidget {
  final Browse browse;

  const BrowseTileWidget({super.key, required this.browse});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(browse.image))), // Menggunakan AssetImage untuk gambar lokal
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                browse.title,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color(0xFF0D1220)),
              ),
              const Gap(8),
              Center(
                child: ButtonWidget(
                  text: 'Detail',
                  onPressed: () {
                    // Navigasi ke halaman RoomDetailPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoomDetailPage(ruangan: browse.ruangan)),
                    );
                  },
                  isFullWidth: false,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
