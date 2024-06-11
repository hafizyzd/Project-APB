import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/presentation/widgets/bid_tile_wodget.dart';
import 'package:nft/presentation/widgets/browse_tile_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:nft/presentation/widgets/bottom_navigation_widget.dart';
import 'package:nft/presentation/widgets/user_info_widget.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: const BottomNavigationWidget(selectedIndex: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            const UserInfoWidget(), 
            _popularBids(),
            _browse()],
        ),
      ),
    );
  }

  Widget _popularBids() {
    var bids = [
      Bid(
          image: 'galeri-06.jpg',
          title: "Coworking Shared",
          ends: "Ruangan Bekerja"),
      Bid(
          image: 'galeri-08.jpg',
          title: "Coworking Private",
          ends: "Ruangan Bekerja"),
      Bid(
          image: 'galeri-07.jpg',
          title: "Rent Office",
          ends: "Ruangan Bekerja"),
      Bid(
          image: 'galeri-09.jpg',
          title: "R. Meeting",
          ends: "Ruangan Bekerja"),
      Bid(
          image: 'galeri-05.jpg',
          title: "Training Room",
          ends: "Ruangan Bekerja")
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: _listTile(
        title: 'Ruangan Gedung B dan D',
        itemHeight: 268,
        itemCount: bids.length,
        itemBuilder: (context, index) => BidTileWidget(
          bid: bids[index],
        ),
      ),
    );
  }

  Widget _browse() {
    var browse = [
      Browse(
          image: 'galeri-05.jpg', title: "R Meeting"),
      Browse(
          image: 'galeri-07.jpg', title: "Coworking Shared"),
      Browse(
          image: "galeri-06.jpg", title: "Training"),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: _listTile(
        title: 'Ruangan Gedung C',
        itemHeight: 196,
        itemCount: browse.length,
        itemBuilder: (context, index) => BrowseTileWidget(
          browse: browse[index],
        ),
      ),
    );
  }

  Column _listTile(
      {required String title,
      required double itemHeight,
      required NullableIndexedWidgetBuilder itemBuilder,
      int itemCount = 5}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color(0xFF0D1220)),
          ),
        ),
        const Gap(16),
        SizedBox(
          height: itemHeight,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: itemBuilder,
              separatorBuilder: (context, index) => const Gap(24),
              itemCount: itemCount),
        )
      ],
    );
  }
}
