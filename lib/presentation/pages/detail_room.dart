import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:btp/presentation/widgets/button_widget.dart';
import 'package:btp/presentation/widgets/user_info_widget.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';
import 'package:btp/presentation/pages/form_page.dart';
import 'package:intl/intl.dart';

class RoomDetailPage extends StatelessWidget {
  final dynamic ruangan;

  const RoomDetailPage({super.key, required this.ruangan});

  String _formatCurrency(String amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(int.parse(amount));
  }

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
                          image: DecorationImage(
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
                        children: [
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Nama Ruangan'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ruangan['nama_ruangan']),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Kapasitas'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${ruangan['kapasitas_ruangan']} Orang'),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Lokasi'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ruangan['lokasi']),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Harga'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Rp${_formatCurrency(ruangan['harga_ruangan'])}'),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Status'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ruangan['tersedia'] == 1 ? 'Tersedia' : 'Tidak Tersedia',
                                style: TextStyle(
                                  color: ruangan['tersedia'] == 1 ? Colors.green : Colors.red,
                                ),
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
