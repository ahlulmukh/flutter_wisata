import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/page/home/main_page.dart';
import 'package:flutter_tugas_akhir/page/my_product_page.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/menu_item.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      fetchMarket();
    });
  }

  fetchMarket() async {
    TokoProvider tokoProvider = Provider.of(context, listen: false);
    await tokoProvider.fetchToko(id: tokoProvider.toko!.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    TokoModel? toko = tokoProvider.toko;

    Widget header() {
      return AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                  (route) => false);
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
          'Toko Saya',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
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
                // CONTENT
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  decoration: BoxDecoration(color: whiteColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(100),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/img_store.png'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                toko!.nameStore.toString(),
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 23,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                toko.village.toString(),
                                style:
                                    blackTextStyle.copyWith(fontWeight: medium),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Deskripsi',
                          style: blackTextStyle.copyWith(
                              fontSize: 20, fontWeight: bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          toko.description.toString(),
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        MenuItem(
                            title: 'Produk Saya',
                            onPressed: () {
                              Get.to(() => MyProductPage(toko: toko),
                                  arguments: toko.products);
                            }),
                        // MenuItem(
                        //     title: 'Tambah Produk',
                        //     onPressed: () {
                        //       Navigator.pushNamed(context, '/add-product');
                        //     }),
                        MenuItem(title: 'Pesanan Baru', onPressed: () {}),
                        MenuItem(
                            title: 'Edit Toko',
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit-store');
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );

    // return SafeArea(
    //   child: Scaffold(
    //       backgroundColor: backgroundColor1,
    //       body: ListView(
    //         children: [
    //           header(),
    //           content(),
    //         ],
    //       )),
    // );
  }
}
