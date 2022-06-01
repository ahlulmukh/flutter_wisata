import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabBar myTab = TabBar(
      indicatorColor: secondaryColor,
      tabs: <Widget>[
        Tab(
          child: Text(
            'In Progress',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
        ),
        Tab(
          child: Text(
            'Completed',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
        ),
      ],
    );

    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: backgroundColor1,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 70.0,
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
          body: const TabBarView(children: [
            Center(
              child: Text('Page 1'),
            ),
            Center(
              child: Text('Page 2'),
            ),
          ]),
        ));
  }
}
