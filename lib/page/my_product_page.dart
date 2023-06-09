import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_my_product.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyProductPage extends StatefulWidget {
  final TokoModel toko;
  const MyProductPage({Key? key, required this.toko}) : super(key: key);

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);

    Widget header() {
      return AppBar(
        centerTitle: true,
        toolbarHeight: 60.0,
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
          'Produk Saya',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget content() {
      if (tokoProvider.toko!.products.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
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
                'Tidak ada produk',
                style:
                    greyTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              )
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(
              top: 40, left: defaultMargin, right: defaultMargin),
          child: SizedBox(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 3
                        : 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                mainAxisExtent: 210, // here set custom Height You Want
              ),
              itemCount: tokoProvider.toko!.products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return CardMyProduct(
                    product:
                        tokoProvider.toko!.products[index] as ProductModel);
              },
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
