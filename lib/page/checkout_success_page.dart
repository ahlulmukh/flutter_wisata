import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/page/part2.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:images_picker/images_picker.dart';
import 'package:scan/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String scannedData = '';

  Future<void> _verifyPayment() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Dio dio = Dio();

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(
        Service.apiUrl + '/verify-payment',
        data: {'data': scannedData},
      );

      if (response.statusCode == 200) {
        // Verifikasi sukses
        var orderData =
            response.data['order']; // Anggap respons mengandung data pesanan
        _showValidationDialog('Pembayaran berhasil diverifikasi', orderData);
      } else {
        // Verifikasi gagal
        print('Verifikasi pembayaran gagal: ${response.data}');
      }
    } catch (e) {
      _showValidationDialogG(
          'Verifikasi pembayaran gagal, saldo harus mencukupi');
    }
  }

  void _showValidationDialog(String message, Map<String, dynamic>? orderData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validasi Pembayaran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              if (orderData != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${orderData['status']}'),
                    Text('Total Harga: Rp.${orderData['total_price']}'),
                    Text('Jumlah: ${orderData['quantities']}'),
                    Text('Nama Tiket: ${orderData['name_ticket']}'),
                    const Text('Harap Simpan bukti pembayaran ini'),
                  ],
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void _showValidationDialogG(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validasi Pembayaran'),
          content: Text(message),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, true); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Warna hijau
        title: const Text('Scan QR Code'),
        centerTitle: true, // Teks judul di tengah
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Tombol terpusat secara horizontal
            children: [
              ElevatedButton(
                child: const Text("Upload dari galeri"),
                onPressed: () async {
                  List<Media>? res = await ImagesPicker.pick();
                  if (res != null) {
                    String? str = await Scan.parse(res[0].path);
                    if (str != null) {
                      setState(() {
                        scannedData = str;
                        _verifyPayment();
                      });
                    }
                  }
                },
              ),
              const SizedBox(width: 10), // Jarak antara tombol
              ElevatedButton(
                child: const Text('Go Scan Page'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ScanQRPage();
                  }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
