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
              statusDetail: 'Status pembayaran belum dibayar',
              colors: Colors.orange,
            ),
            StatusWidget(
              status: 'Success',
              statusDetail: 'Status produk sudah diterima ke user',
              colors: primaryColor,
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
              'Tata Cara Pembelian Ticket',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Tata cara pembelian produk yaitu pilih salah satu atau klik item tiket yang ingin belikan kemudian akan diarahkan ke halaman detail produk, selanjutnya tambahkan ke book, selanjutnya muncul dialog telah berhasil di tambah ke dalam book, kemudian pada halaman keranjang tersebut bisa menambahkan item quantity tiket.\nselanjutnya pada halaman pembayaran isikan input nama kemudian sung checkout.',
              textAlign: TextAlign.justify,
              style: greyTextStyle.copyWith(fontWeight: semiBold),
            )
          ],
        ),
      );
    }

    Widget tutorialBuySaldo() {
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
              'Tata Cara Top Up Saldo',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Tata cara melakukan top up saldo yaitu dengan cara masuk ke halaman home page, kemudian isikan nominal saldo dan lakukan pengiriman ke nomor rek yang disediakan dengan mengupload slip pembayaran pada form image.\nselanjutnya jika top up saldo sebelumya masih dalam status pending maka saldo page belum bisa dibuka. Jika slip valid maka saldo akan masuk, jika gagal saldo tidak akan masuk, silahkan melakukan top up ulang',
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
          tutorialBuySaldo(),
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
