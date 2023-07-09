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
      Dio dio = Dio(); // Membuat instance Dio

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(
        Service.apiUrl +
            '/verify-payment', // Ganti dengan URL endpoint verifikasi pembayaran Anda
        data: {'data': scannedData},
      );

      if (response.statusCode == 200) {
        // Verifikasi sukses
        print('Pembayaran berhasil diverifikasi');
      } else {
        // Verifikasi gagal
        print('Verifikasi pembayaran gagal: ${response.data}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: [
          const Text('Waduh'),
          Wrap(
            children: [
              ElevatedButton(
                child: const Text("parse from image"),
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
              ElevatedButton(
                child: const Text('go scan page'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return scanQR();
                  }));
                },
              ),
            ],
          ),
          Text('scan result is $scannedData'),
        ],
      ),
    );
  }
}
