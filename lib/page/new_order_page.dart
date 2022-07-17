// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/order_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/provider/order_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/order_market.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({Key? key}) : super(key: key);

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  int currentIndex = 0;
  bool isLoading = true;

  Future<void> orderMarket() async {
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    TokoProvider tokoProvider =
        Provider.of<TokoProvider>(context, listen: false);
    TokoModel? toko = tokoProvider.toko;
    await orderProvider.orderMarket(id: toko!.id!.toInt());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    orderMarket();
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    TabBar myTab = TabBar(
      indicatorColor: secondaryColor,
      unselectedLabelColor: greyColor,
      labelColor: lightColor,
      indicatorWeight: 3.0,
      tabs: <Widget>[
        Tab(
          child: Text(
            'Order',
            style: GoogleFonts.poppins(fontWeight: semiBold, fontSize: 16),
          ),
        ),
        Tab(
          child: Text(
            'Completed',
            style: GoogleFonts.poppins(fontWeight: semiBold, fontSize: 16),
          ),
        ),
      ],
    );

    return DefaultTabController(
      length: 2,
      initialIndex: currentIndex,
      child: Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.0,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Pesanan Baru',
            style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
          ),
          bottom: PreferredSize(
            child: Container(
              color: backgroundColor1,
              child: myTab,
            ),
            preferredSize: Size.fromHeight(myTab.preferredSize.height),
          ),
        ),
        body: TabBarView(children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: secondaryColor,
                  strokeWidth: 8.0,
                ))
              : (orderProvider.orders!.isEmpty)
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Image.asset(
                          'assets/no_order.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Belum ada pesanan',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                              fontSize: 22, fontWeight: semiBold),
                        )
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: orderMarket,
                      child: (orderProvider.orders!.where((orderStatus) =>
                                  orderStatus.status == OrderStatus.pending ||
                                  orderStatus.status == OrderStatus.progress ||
                                  orderStatus.status ==
                                      OrderStatus.delivery)).length ==
                              0
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  Image.asset(
                                    'assets/no_order.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 250,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Belum ada pesanan',
                                    textAlign: TextAlign.center,
                                    style: greyTextStyle.copyWith(
                                        fontSize: 22, fontWeight: semiBold),
                                  )
                                ],
                              ),
                            )
                          : ListView(
                              children: orderProvider.orders!
                                  .where((userId) =>
                                      userId.usersId == userId.usersId)
                                  .toList()
                                  .where((orderStatus) =>
                                      orderStatus.status ==
                                          OrderStatus.pending ||
                                      orderStatus.status ==
                                          OrderStatus.progress ||
                                      orderStatus.status ==
                                          OrderStatus.delivery)
                                  .toList()
                                  .map((order) => OrderToMarket(order: order))
                                  .toList()),
                    ),
          orderProvider.orders!.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Image.asset(
                      'assets/no_order.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 250,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Belum ada pesanan',
                      textAlign: TextAlign.center,
                      style: greyTextStyle.copyWith(
                          fontSize: 22, fontWeight: semiBold),
                    )
                  ],
                )
              : ListView(
                  children: orderProvider.orders!
                      .where((orderStatus) =>
                          orderStatus.status == OrderStatus.cancel ||
                          orderStatus.status == OrderStatus.success)
                      .toList()
                      .map((order) => OrderToMarket(order: order))
                      .toList()),
        ]),
      ),
    );
  }
}
