import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/presentation/widgets/button_widget.dart';
import 'package:nft/presentation/pages/detail_room.dart';

class Bid {
  final String image;
  final String title;
  final String ends;

  Bid({
    required this.image,
    required this.title,
    required this.ends,
  });
}

class BidTileWidget extends StatelessWidget {
  final Bid bid;
  const BidTileWidget({super.key, required this.bid});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 270,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/${bid.image}'))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bid.title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: const Color(0xFF0D1220)),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Text(
                          bid.ends,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF909FB4)),
                        ),
                        const Gap(8),
                        ButtonWidget(
                          text: 'Detail',
                          onPressed: () {
                            // Navigasi ke halaman RoomDetailPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RoomDetailPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        )
      ]),
    );
  }
}
