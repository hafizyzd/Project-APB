import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:btp/presentation/widgets/bid_tile_widget.dart';
import 'package:btp/presentation/widgets/browse_tile_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/user_info_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<dynamic> _ruanganList = [];
  List<dynamic> _popularBids = [];
  List<dynamic> _browse = [];

  final List<String> _imageList = [
    'assets/images/DSC00050-768x512.jpg',
    'assets/images/DSC00086-1-768x512.jpg',
    'assets/images/DSC00331-1024x683.jpg',
    'assets/images/galeri-05.jpg',
    'assets/images/galeri-06.jpg',
    'assets/images/galeri-07.jpg',
    'assets/images/galeri-08.jpg',
    'assets/images/galeri-09.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _fetchRuangan();
  }

  Future<void> _fetchRuangan() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/ruangan'));

    if (response.statusCode == 200) {
      setState(() {
        _ruanganList = jsonDecode(response.body);
        _popularBids = _ruanganList
            .where((ruangan) =>
                ruangan['lokasi'].toLowerCase().contains('gedung b') ||
                ruangan['lokasi'].toLowerCase().contains('gedung d'))
            .toList();
        _browse = _ruanganList
            .where((ruangan) =>
                ruangan['lokasi'].toLowerCase().contains('gedung a') ||
                ruangan['lokasi'].toLowerCase().contains('gedung c') ||
                ruangan['lokasi'].toLowerCase().contains('-'))
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data ruangan')),
      );
    }
  }

  String _getRepeatedImageUrl(int index) {
    return _imageList[index % _imageList.length];
  }

  String _getReversedImageUrl(int index) {
    return _imageList[_imageList.length - 1 - (index % _imageList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: const BottomNavigationWidget(selectedIndex: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            const UserInfoWidget(),
            _popularBidsWidget(),
            _browseWidget(),
          ],
        ),
      ),
    );
  }

  Widget _popularBidsWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: _listTile(
        title: 'Ruangan Gedung B dan D',
        itemHeight: 268,
        itemCount: _popularBids.length,
        itemBuilder: (context, index) => SizedBox(
          width: 200, // Set a fixed width for each item
          child: BidTileWidget(
            bid: Bid(
              image: _getRepeatedImageUrl(index), // use repeated image URL
              title: _popularBids[index]['nama_ruangan'],
              ends: _popularBids[index]['lokasi'],
              ruangan: _popularBids[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _browseWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: _listTile(
        title: 'Ruangan Gedung A, C, dan Lainnya',
        itemHeight: 196,
        itemCount: _browse.length,
        itemBuilder: (context, index) => SizedBox(
          width: 200, // Set a fixed width for each item
          child: BrowseTileWidget(
            browse: Browse(
              image: _getReversedImageUrl(index), // use reversed image URL
              title: _browse[index]['nama_ruangan'],
              ruangan: _browse[index],
            ),
          ),
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
