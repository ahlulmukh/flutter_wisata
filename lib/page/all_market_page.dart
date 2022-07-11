import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_market.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllMarketPage extends StatefulWidget {
  const AllMarketPage({Key? key}) : super(key: key);

  @override
  State<AllMarketPage> createState() => _AllMarketPageState();
}

class _AllMarketPageState extends State<AllMarketPage> {
  bool isLoading = true;

  getAllMarket() async {
    TokoProvider tokoProvider = Provider.of(context, listen: false);
    await tokoProvider.getMarkets();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllMarket();
  }

  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);

    Widget header() {
      return AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
        backgroundColor: whiteColor,
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
        elevation: 0,
        title: Text(
          'Semua Toko',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget getGridViewMarket() {
      if (tokoProvider.markets.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/no_box.svg',
                width:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.8,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tidak ada Toko',
                style:
                    greyTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              )
            ],
          ),
        );
      } else {
        return SizedBox(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 16,
              mainAxisExtent: 200, // here set custom Height You Want
            ),
            itemCount: tokoProvider.markets.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CardMarket(toko: tokoProvider.markets[index] as TokoModel);
            },
          ),
        );
      }
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getGridViewMarket(),
            ]),
      );
    }

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: secondaryColor,
              strokeWidth: 8.0,
            ))
          : ListView(
              children: [
                header(),
                content(),
              ],
            ),
    );
  }
}
