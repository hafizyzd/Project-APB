import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft/presentation/widgets/button_widget.dart';
import 'package:nft/presentation/widgets/user_info_widget.dart';
import 'package:nft/presentation/widgets/bottom_navigation_widget.dart';
import 'package:nft/presentation/widgets/page_widget.dart';
import 'package:nft/presentation/pages/form_page.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: const BottomNavigationWidget(selectedIndex: 0),
      child: Column(
        children: [
          const Gap(20),
          const UserInfoWidget(), // Pengganti AppBar
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/galeri-07.jpg'), // Ganti dengan path gambar lokal Anda
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(3),
                        },
                        children: const [
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Nama Ruangan'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Multimedia'),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Kapasitas'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('50 Orang'),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Lokasi'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Gedung A'),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Harga'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Rp70000'),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Status'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Tersedia',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Keterangan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('*Harga Diatas belum termasuk PPN (sesuai dengan ketentuan regulasi yang berlaku)'),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('**Harap membaca Syarat & ketentuan yang berlaku'),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ButtonWidget(
                        text: 'Pinjam Ruangan',
                        onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const FormPage(),
                        ));
                        },
                        isFullWidth: false, // Set sesuai kebutuhan
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
