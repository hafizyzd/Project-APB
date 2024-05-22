import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/constants/color_constant.dart';
import 'package:nft/presentation/widgets/bid_tile_wodget.dart';
import 'package:nft/presentation/widgets/browse_tile_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:nft/presentation/pages/form_page.dart';
import 'package:nft/presentation/pages/account_page.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: _bottomNavigationBar(context),
      child: SingleChildScrollView(
        child: Column(
          children: [_userInfo(), _popularBids(), _browse()],
        ),
      ),
    );
  }

  Widget _userInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //Avatar
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorConstant.primary),
                      borderRadius: BorderRadius.circular(60 / 2)),
                  child: Image.asset('assets/images/User1.png'),
                ),
                const Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Somay',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xFF0D1220)),
                    ),
                    const Gap(6),
                    Text(
                      'Penyewa',
                      style: GoogleFonts.inter(
                          fontSize: 14, color: Color.fromARGB(255, 48, 52, 59)),
                    ),
                  ],
                )
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/svgs/notification.svg')),
            )
          ],
        ),
      );

  Widget _popularBids() {
    var bids = [
      Bid(
          image:
              'galeri-06.jpg',
          title: "Coworking Shared",
          ends: "Ruangan Berkapasitas 30 orang"),
      Bid(
          image:
              'galeri-08.jpg',
          title: "Coworking Private",
          ends: "Ruangan Berkapasitas 30 orang"),
      Bid(
          image:
              'galeri-07.jpg',
          title: "Rent Office",
          ends: "Ruangan Berkapasitas 30 orang"),
      Bid(
          image:
              'galeri-09.jpg',
          title: "R. Meeting",
          ends: "Ruangan Berkapasitas 30 orang"),
      Bid(
          image:
              'galeri-05.jpg',
          title: "Training Room",
          ends: "Ruangan Berkapasitas 30 orang")
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
          image: 'galeri-05.jpg', title: "Aula", itemCount: 10000),
      Browse(
          image: 'galeri-07.jpg', title: "Coworking Shared", itemCount: 10000),
      Browse(
          image: "galeri-06.jpg", title: "Membuat Ketupat", itemCount: 10000),
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

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_add_check_circle_rounded, size: 26, color: Color(0xFFED3C35)),
          label: 'Ruangan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet_rounded, size: 26, color: Color(0xFFED3C35)),
          label: 'Form',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle, size: 26, color: Color(0xFFED3C35)),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, size: 26, color: Color(0xFFED3C35)),
          label: 'Akun',
        ),
      ],
      selectedItemColor: const Color(0xFFED3C35), // Selected icon and label color
      unselectedItemColor: Colors.grey, // Unselected icon and label color
      showSelectedLabels: true, // Show labels for selected items
      showUnselectedLabels: true, // Show labels for unselected items
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscoverPage()),
            );
            break;
          case 1:
            // Navigasi ke halaman Form Peminjaman
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => FormPage()),
            // );
            break;
          case 2:
            // Navigasi ke halaman Status Ruangan
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => StatusPage()),
            // );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
            break;
        }
      },
    );
  }
}
