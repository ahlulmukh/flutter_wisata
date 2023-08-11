import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/services/service.dart'; // Pastikan Anda mengganti dengan path yang benar
import 'package:scan/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({Key? key}) : super(key: key);

  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  ScanController controller = ScanController();

  Future<void> _verifyPayment(String data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Dio dio = Dio();

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(
        Service.apiUrl + '/verify-payment',
        data: {'data': data},
      );

      if (response.statusCode == 200) {
        // Verifikasi sukses
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Verifikasi Pembayaran'),
              ),
              body: const Center(
                child: Text('Pembayaran berhasil diverifikasi'),
              ),
            );
          },
        ));
      } else {
        // Verifikasi gagal
        print('Verifikasi pembayaran gagal: ${response.data}');
      }
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Verifikasi Pembayaran'),
            ),
            body: const Center(
              child: Text('Verifikasi pembayaran gagal, saldo harus mencukupi'),
            ),
          );
        },
      ));
    }
    controller.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Stack(
          children: [
            ScanView(
              controller: controller,
              scanAreaScale: .7,
              scanLineColor: Colors.green,
              onCapture: (data) {
                _verifyPayment(data);
              },
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text("Toggle Torch"),
                    onPressed: () {
                      controller.toggleTorchMode();
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Pause"),
                    onPressed: () {
                      controller.pause();
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Resume"),
                    onPressed: () {
                      controller.resume();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
