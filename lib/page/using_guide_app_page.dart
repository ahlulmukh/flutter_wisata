import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class UsingGuideAppPage extends StatelessWidget {
  const UsingGuideAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        toolbarHeight: 60.0,
        backgroundColor: whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Panduan Aplikasi',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget guideBuyingProduct() {
      return Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(top: 20, left: defaultMargin, right: defaultMargin),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pembayaran',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const StatusWidget(
              status: 'Pending',
              statusDetail: 'Status pembayaran belum dikonfirmasi',
              colors: Colors.orange,
            ),
            const StatusWidget(
              status: 'Progress',
              statusDetail: 'Status pembayaran sedang diproses',
              colors: Colors.yellow,
            ),
            StatusWidget(
              status: 'Delivery',
              statusDetail: 'Status pembayaran produk sedang dalam perjalanan',
              colors: lightColor,
            ),
            StatusWidget(
              status: 'Success',
              statusDetail: 'Status produk sudah diterima ke user',
              colors: primaryColor,
            ),
            StatusWidget(
              status: 'Cancel',
              statusDetail: 'Status pembayaran produk ditolak dari penjual',
              colors: Colors.red[800] as Color,
            ),
          ],
        ),
      );
    }

    Widget tutorialBuyProduct() {
      return Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(top: 20, left: defaultMargin, right: defaultMargin),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tata Cara Pembelian Produk',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Tata cara pembelian produk yaitu pilih salah satu atau klik item produk yang ingin belikan kemudian akan diarahkan ke halaman detail produk, selanjutnya tambahkan ke keranjang, selanjutnya muncul dialog telah berhasil di tambah ke dalam keranjang, kemudian pada halaman keranjang tersebut bisa menambahkan item quantity produk sampai pada persediaan produk dari penjual.\nselanjutnya pada halaman pembayaran isikan input untuk tujuan pengiriman produk yaitu nomor hp, alamat dan gambar bukti upload slip pembayaran yang telah dilakukannya dan tunggu proses konfirmasi pembelian produk dari penjual.',
              textAlign: TextAlign.justify,
              style: greyTextStyle.copyWith(fontWeight: semiBold),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: ListView(
        children: [
          header(),
          guideBuyingProduct(),
          tutorialBuyProduct(),
        ],
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  final String status;
  final String statusDetail;
  final Color colors;

  const StatusWidget({
    Key? key,
    required this.status,
    required this.statusDetail,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: whiteTextStyle.copyWith(
                color: colors, fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            statusDetail,
            style: greyTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      ),
    );
  }
}
