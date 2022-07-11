import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/order_model.dart';
import 'package:flutter_tugas_akhir/provider/order_provider.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/order_item_list.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class OrderToMarket extends StatelessWidget {
  final OrderModel order;
  const OrderToMarket({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

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
                  Text(
                    'Slip Pembayaran',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Hero(
                    tag: 'payment',
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HeroPaymentPage(
                                    order: order,
                                  ))),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                                Service.urlImage + order.image.toString()),
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Alamat',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    order.address.toString(),
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No Hp',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    order.phone.toString(),
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Produk',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: order.orderItem!
                        .map((orderItem) => OrderItemList(
                              orderItem: orderItem,
                            ))
                        .toList(),
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
                            currencyFormatter.format(order.totalPrice),
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
                          (order.status == OrderStatus.pending)
                              ? Text(
                                  'pending',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: medium,
                                  ),
                                )
                              : (order.status == OrderStatus.progress)
                                  ? Text(
                                      'progress',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: medium,
                                      ),
                                    )
                                  : (order.status == OrderStatus.delivery)
                                      ? Text(
                                          'delivery',
                                          style: TextStyle(
                                            color: lightColor,
                                            fontWeight: medium,
                                          ),
                                        )
                                      : (order.status == OrderStatus.success)
                                          ? Text(
                                              'success',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: medium,
                                              ),
                                            )
                                          : (order.status == OrderStatus.cancel)
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
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: order.user!.profilePhotoPath == null
                      ? const DecorationImage(
                          image: AssetImage('assets/images/user.png'),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: NetworkImage(Service.urlImage +
                              order.user!.profilePhotoPath.toString()),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.user!.name.toString(),
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'Total harga : ' +
                          currencyFormatter.format(order.totalPrice),
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
                            'Detail Order',
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
              (order.status == OrderStatus.pending)
                  ? TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(6)),
                        backgroundColor: lightColor,
                      ),
                      onPressed: () async {
                        await OrderProvider().statusOrder(
                            id: order.id!.toInt(), status: 'PROGRESS');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: secondaryColor,
                          content: Text(
                            'Status berhasil diubah silahkan refresh ulang',
                            textAlign: TextAlign.center,
                            style:
                                whiteTextStyle.copyWith(fontWeight: semiBold),
                          ),
                        ));
                      },
                      child: Text('Konfirmasi',
                          style: whiteTextStyle.copyWith(fontWeight: bold)),
                    )
                  : (order.status == OrderStatus.progress)
                      ? TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: const Size.fromWidth(120),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(6)),
                            backgroundColor: secondaryColor,
                          ),
                          onPressed: () async {
                            await OrderProvider().statusOrder(
                                id: order.id!.toInt(), status: 'DELIVERY');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: secondaryColor,
                                content: Text(
                                  'Status berhasil diubah silahkan refresh ulang',
                                  textAlign: TextAlign.center,
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                              ),
                            );
                          },
                          child: Text('Kirim',
                              style: whiteTextStyle.copyWith(fontWeight: bold)),
                        )
                      : const SizedBox(),
              order.status == OrderStatus.delivery
                  ? TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(6)),
                        backgroundColor: greyColor,
                      ),
                      onPressed: () {},
                      child: Text('Delivery',
                          style: whiteTextStyle.copyWith(fontWeight: bold)),
                    )
                  : const SizedBox(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    convertDateTime(order.createdAT as DateTime),
                    textAlign: TextAlign.end,
                    style: greyTextStyle,
                  ),
                  (order.status == OrderStatus.pending)
                      ? Text(
                          'pending',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: medium,
                          ),
                        )
                      : (order.status == OrderStatus.progress)
                          ? Text(
                              'progress',
                              style: TextStyle(
                                color: Colors.yellow[600],
                                fontWeight: medium,
                              ),
                            )
                          : (order.status == OrderStatus.delivery)
                              ? Text(
                                  'delivery',
                                  style: TextStyle(
                                    color: lightColor,
                                    fontWeight: medium,
                                  ),
                                )
                              : (order.status == OrderStatus.success)
                                  ? Text(
                                      'success',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: medium,
                                      ),
                                    )
                                  : (order.status == OrderStatus.cancel)
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

class HeroPaymentPage extends StatelessWidget {
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
              child: PhotoView(
                  imageProvider:
                      NetworkImage(Service.urlImage + order.image.toString())),
            )),
      ),
    );
  }
}
