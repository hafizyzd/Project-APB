import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:btp/presentation/widgets/bottom_navigation_widget.dart';
import 'package:btp/presentation/widgets/button_widget.dart';
import 'package:btp/presentation/widgets/user_info_widget.dart';
import 'package:btp/presentation/widgets/page_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final int _selectedIndex = 1;
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime.hour >= 6 && pickedTime.hour < 18) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      bottomNavigationBar: BottomNavigationWidget(selectedIndex: _selectedIndex),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20),
              const UserInfoWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nama Peminjam',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Nama Peminjam!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Ruangan',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'rent_office',
                            child: Text('Rent Office'),
                          ),
                          DropdownMenuItem(
                            value: 'coworking_space_p',
                            child: Text('Coworking Space Private'),
                          ),
                          DropdownMenuItem(
                            value: 'coworking_space_s',
                            child: Text('Coworking Space Shared'),
                          ),
                          DropdownMenuItem(
                            value: 'virtual_office',
                            child: Text('Virtual Office'),
                          ),
                          DropdownMenuItem(
                            value: 'multimedia',
                            child: Text('Multimedia'),
                          ),
                          DropdownMenuItem(
                            value: 'Aula',
                            child: Text('Aula'),
                          ),
                          DropdownMenuItem(
                            value: 'training',
                            child: Text('Training'),
                          ),
                          DropdownMenuItem(
                            value: 'overtime',
                            child: Text('Overtime'),
                          ),
                        ],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null) {
                            return 'Masukkan ruangan anda!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Lokasi',
                        ),
                        enabled: false,
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Harga',
                        ),
                        enabled: false,
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Peserta',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Jumlah Peserta!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tanggal Mulai Peminjaman',
                        ),
                        controller: TextEditingController(
                          text: _startDate == null
                              ? ''
                              : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                        ),
                        onTap: () => _selectDate(context, true),
                        readOnly: true,
                        validator: (value) {
                          if (_startDate == null) {
                            return 'Masukkan Mulai Peminjaman!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tanggal Selesai Peminjaman',
                        ),
                        controller: TextEditingController(
                          text: _endDate == null
                              ? ''
                              : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                        ),
                        onTap: () => _selectDate(context, false),
                        readOnly: true,
                        validator: (value) {
                          if (_endDate == null) {
                            return 'Masukkan Selesai Peminjaman!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jam Mulai Peminjaman',
                        ),
                        controller: TextEditingController(
                          text: _startTime == null
                              ? ''
                              : '${_startTime!.format(context)}',
                        ),
                        onTap: () => _selectTime(context, true),
                        readOnly: true,
                        validator: (value) {
                          if (_startTime == null) {
                            return 'Masukkan Mulai Peminjaman!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jam Selesai Peminjaman',
                        ),
                        controller: TextEditingController(
                          text: _endTime == null
                              ? ''
                              : '${_endTime!.format(context)}',
                        ),
                        onTap: () => _selectTime(context, false),
                        readOnly: true,
                        validator: (value) {
                          if (_endTime == null) {
                            return 'Masukkan Selesai Peminjaman!';
                          }
                          return null;
                        },
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Catatan',
                        ),
                        maxLines: 4,
                      ),
                      const Gap(16),
                      ButtonWidget(
                        text: 'Kirim Pengajuan',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process the submission
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
