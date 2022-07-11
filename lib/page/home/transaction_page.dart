import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/order_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/order_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/order_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int currentIndex = 0;
  bool isLoading = true;

  Future orderUser() async {
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    UserModel? user = authProvider.user;
    await orderProvider.orderUser(id: user!.id!.toInt());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    orderUser();
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of(context);

    TabBar myTab = TabBar(
      indicatorWeight: 3.0,
      unselectedLabelColor: greyColor,
      labelColor: lightColor,
      indicatorColor: secondaryColor,
      tabs: <Widget>[
        Tab(
          child: Text(
            'In Progress',
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
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Transaksi',
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
                          'Belum ada transaksi',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                              fontSize: 22, fontWeight: semiBold),
                        )
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: orderUser,
                      child: ListView(
                          children: orderProvider.orders!
                              .where(
                                  (userId) => userId.usersId == userId.usersId)
                              .toList()
                              .where((orderStatus) =>
                                  orderStatus.status == OrderStatus.pending ||
                                  orderStatus.status == OrderStatus.progress ||
                                  orderStatus.status == OrderStatus.delivery)
                              .toList()
                              .map((order) => OrderList(order: order))
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
                      'Belum ada transaksi',
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
                      .map((order) => OrderList(order: order))
                      .toList()),
        ]),
      ),
    );
  }
}
