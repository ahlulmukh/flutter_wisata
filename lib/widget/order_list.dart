import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/order_model.dart';
import 'package:flutter_tugas_akhir/page/checkout_success_page.dart';
import 'package:flutter_tugas_akhir/provider/order_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  final OrderModel order;
  const OrderList({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  bool shouldRefresh = false;

  Future<void> _downloadPDF() async {
    if (widget.order.strukurl != null &&
        (widget.order.strukurl!.startsWith('http://') ||
            widget.order.strukurl!.startsWith('https://'))) {
      try {
        // Lakukan permintaan jaringan untuk mengunduh PDF
        final response = await http.get(Uri.parse(widget.order.strukurl!));

        // Dapatkan direktori penyimpanan eksternal (misalnya, galeri)
        Directory? externalDir = await getExternalStorageDirectory();

        if (externalDir != null) {
          // Buat file baru dengan nama unik di direktori penyimpanan eksternal
          File file = File('${externalDir.path}/order_${widget.order.id}.pdf');

          // Tulis konten yang diunduh ke dalam file
          await file.writeAsBytes(response.bodyBytes);
          print('PDF berhasil diunduh ke: ${file.path}');
        } else {
          print('Tidak dapat mengakses direktori penyimpanan eksternal.');
        }
      } catch (e) {
        print('Gagal mengunduh PDF: $e');
      }
    } else {
      print('URL PDF tidak valid');
    }
  }

  void _navigateToScanPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanPage()),
    );

    if (result == true) {
      setState(() {
        shouldRefresh =
            true; // Set shouldRefresh menjadi true untuk melakukan refresh
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    Widget buildSheet() => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: controller,
                children: [
                  Text(
                    'List Order',
                    style:
                        blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  (widget.order.status == OrderStatus.pending)
                      ? Hero(
                          tag: 'payment',
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HeroPaymentPage(
                                          order: widget.order,
                                        ))),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.order.qrcodeurl.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: greyColor.withOpacity(0.6)),
                                  child: Text(
                                    'Lihat',
                                    textAlign: TextAlign.center,
                                    style: whiteTextStyle.copyWith(
                                        fontWeight: semiBold, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    'Nama Pembeli',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.order.nama.toString(),
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ticket',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.order.nameticket.toString(),
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Jumlah Tiket',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.order.quantities.toString(),
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Harga',
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            currencyFormatter.format(widget.order.totalPrice),
                            style: greyTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          (widget.order.status == OrderStatus.pending)
                              ? Text(
                                  'pending',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: medium,
                                  ),
                                )
                              : (widget.order.status == OrderStatus.progress)
                                  ? Text(
                                      'progress',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: medium,
                                      ),
                                    )
                                  : (widget.order.status ==
                                          OrderStatus.delivery)
                                      ? Text(
                                          'delivery',
                                          style: TextStyle(
                                            color: lightColor,
                                            fontWeight: medium,
                                          ),
                                        )
                                      : (widget.order.status ==
                                              OrderStatus.success)
                                          ? Text(
                                              'success',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: medium,
                                              ),
                                            )
                                          : (widget.order.status ==
                                                  OrderStatus.cancel)
                                              ? Text(
                                                  'cancel',
                                                  style: TextStyle(
                                                    color: Colors.red[800],
                                                    fontWeight: medium,
                                                  ),
                                                )
                                              : const SizedBox(),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ));

    return Container(
      padding: const EdgeInsets.only(left: 18, right: 10, bottom: 10, top: 24),
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total harga : ' +
                          currencyFormatter.format(widget.order.totalPrice),
                      style: greyTextStyle.copyWith(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => buildSheet(),
                        backgroundColor: Colors.transparent,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Detail Item',
                            style:
                                whiteTextStyle.copyWith(fontWeight: semiBold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              (widget.order.status == OrderStatus.pending ||
                      widget.order.status == OrderStatus.progress)
                  ? TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(6)),
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: _navigateToScanPage,
                      child: Text('Scan QR',
                          style: whiteTextStyle.copyWith(fontWeight: bold)),
                    )
                  : const SizedBox(),
              (widget.order.status == OrderStatus.success)
                  ? TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(6)),
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: () {
                        _downloadPDF();
                      },
                      child: Text('Unduh Slip',
                          style: whiteTextStyle.copyWith(fontWeight: bold)),
                    )
                  : const SizedBox(),
              widget.order.status == OrderStatus.delivery
                  ? TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(6)),
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: () {
                        orderProvider.statusOrder(
                            widget.order.id!.toInt(), 'SUCCESS');
                        Get.snackbar('', '',
                            margin: EdgeInsets.only(
                                top: 20,
                                left: defaultMargin,
                                right: defaultMargin),
                            backgroundColor: secondaryColor,
                            titleText: Text(
                              'Sukses',
                              style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 17),
                            ),
                            messageText: Text('Produk berhasil diterima',
                                style: whiteTextStyle.copyWith(fontSize: 14)),
                            colorText: Colors.white);
                      },
                      child: Text('Terima Produk',
                          style: whiteTextStyle.copyWith(fontWeight: bold)),
                    )
                  : const SizedBox(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    convertDateTime(widget.order.createdAT as DateTime),
                    textAlign: TextAlign.end,
                    style: greyTextStyle,
                  ),
                  (widget.order.status == OrderStatus.pending)
                      ? Text(
                          'pending',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: medium,
                          ),
                        )
                      : (widget.order.status == OrderStatus.progress)
                          ? Text(
                              'progress',
                              style: TextStyle(
                                color: Colors.yellow[600],
                                fontWeight: medium,
                              ),
                            )
                          : (widget.order.status == OrderStatus.delivery)
                              ? Text(
                                  'delivery',
                                  style: TextStyle(
                                    color: lightColor,
                                    fontWeight: medium,
                                  ),
                                )
                              : (widget.order.status == OrderStatus.success)
                                  ? Text(
                                      'success',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: medium,
                                      ),
                                    )
                                  : (widget.order.status == OrderStatus.cancel)
                                      ? Text(
                                          'cancel',
                                          style: TextStyle(
                                            color: Colors.red[800],
                                            fontWeight: medium,
                                          ),
                                        )
                                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String convertDateTime(DateTime dateTime) {
    String? month;

    switch (dateTime.month) {
      case 1:
        month = 'Januari';
        break;
      case 2:
        month = 'Februari';
        break;
      case 3:
        month = 'Maret';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'Mei';
        break;
      case 6:
        month = 'Juni';
        break;
      case 7:
        month = 'Juli';
        break;
      case 8:
        month = 'Augustus';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Oktober';
        break;
      case 11:
        month = 'November';
        break;
      default:
        month = 'Desember';
    }

    return month + ' ${dateTime.day}, ${dateTime.hour}:${dateTime.minute}';
  }
}

class HeroPaymentPage extends StatelessWidget {
  Future<void> _saveImageToGallery(String imageUrl) async {
    try {
      await GallerySaver.saveImage(imageUrl);
      print('Gambar berhasil disimpan ke galeri');
      // Tambahkan penanganan sukses
    } catch (e) {
      print('Gagal menyimpan gambar ke galeri: $e');
      // Tambahkan penanganan gagal
    }
  }

  final OrderModel order;
  const HeroPaymentPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'payment',
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(order.qrcodeurl.toString()),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveImageToGallery(order.qrcodeurl.toString());
                    },
                    child: const Text('Simpan ke Galeri'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
