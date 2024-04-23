import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/constants/color_constant.dart';
import 'package:nft/presentation/widgets/bid_tile_wodget.dart';
import 'package:nft/presentation/widgets/browse_tile_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        bottomNavigationBar: _bottomNavigationBar(),
        child: SingleChildScrollView(
          child: Column(
            children: [_userInfo(), _popularBids(), _browse()],
          ),
        ));
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
                      'Level 109',
                      style: GoogleFonts.inter(
                          fontSize: 14, color: const Color(0xFF909FB4)),
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
              'https://igdhuwnfxnlgnizlnjjc.supabase.co/storage/v1/object/public/images/cultures/6/tari-kijang-1.jpg',
          title: "Tari Kijang",
          ends: "10m 11s",
          price: "4.5"),
      Bid(
          image:
              'https://i.ytimg.com/vi/vdbrpyIQ_s0/hq720.jpg?sqp=-oaymwE7CK4FEIIDSFryq4qpAy0IARUAAAAAGAElAADIQj0AgKJD8AEB-AH-CYAC0AWKAgwIABABGGUgXChaMA8=&rs=AOn4CLC0_WFFvQuE6_szUO-Zk-BWd5Hilw',
          title: "Tari Kulinan",
          ends: "12m 23s",
          price: "4.8"),
      Bid(
          image:
              'https://igdhuwnfxnlgnizlnjjc.supabase.co/storage/v1/object/public/images/cultures/8/tari-kembang-buruan-1.jpg',
          title: "Tari Kembang Baruan",
          ends: "15m 11s",
          price: "5.0")
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: _listTile(
        title: 'Mengenal Budaya Tari',
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
          image:
              'https://igdhuwnfxnlgnizlnjjc.supabase.co/storage/v1/object/public/images/crafts/1.png',
          title: "Cangkir Daun Pisang",
          itemCount: 10000),
      Browse(
          image:
              'https://igdhuwnfxnlgnizlnjjc.supabase.co/storage/v1/object/public/images/crafts/2.png',
          title: "Membuat Sudi",
          itemCount: 10000),
      Browse(
          image:
              "https://cdn0-production-images-kly.akamaized.net/bhRtPIXmpAgfo0ae_YHQGSS53zg=/1200x1200/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/4397082/original/040126000_1681619748-mufid-majnun-nrDFC5u6q9Y-unsplash.jpg",
          title: "Membuat Ketupat",
          itemCount: 10000),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: _listTile(
        title: 'Belajar Membuat Kerajinan',
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

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Color.fromRGBO(118, 88, 39, 100)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.games_outlined, color: Color.fromRGBO(118, 88, 39, 100)),
          label: 'Game',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined, color: Color.fromRGBO(118, 88, 39, 100)),
          label: 'Ulasan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined, color: Color.fromRGBO(118, 88, 39, 100),),
          label: 'Akun'
        ),
      ],
  );

  }
}
