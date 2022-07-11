import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
        backgroundColor: backgroundColor3,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon_success.png',
                width: 132,
                height: 132,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pembayaran Berhasil',
                style:
                    whiteTextStyle.copyWith(fontSize: 20, fontWeight: medium),
              ),
              Text(
                'Mohon tunggu\n konfirmasi dari penjual',
                textAlign: TextAlign.center,
                style:
                    whiteTextStyle.copyWith(fontSize: 20, fontWeight: medium),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/main-page',
                      arguments: pageProvider.currentIndex = 1);
                },
                child: Container(
                  width: double.infinity,
                  height: 49,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'Halaman Transaksi',
                      style: whiteTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
