import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/page/edit_store_page.dart';
import 'package:flutter_tugas_akhir/page/my_product_page.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/menu_item.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  final TokoModel toko;

  const StorePage({
    Key? key,
    required this.toko,
  }) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMarket();
  }

  fetchMarket() async {
    TokoProvider tokoProvider = Provider.of(context, listen: false);
    await tokoProvider.fetchToko(
        id: Get.arguments ?? tokoProvider.toko?.id?.toInt());
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
        toolbarHeight: 60.0,
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Get.offNamedUntil('/main-page', (route) => false);
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
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/photo_border.png'),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: toko!.image.toString(),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/user.png',
                                        )),
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
                                toko.nameStore.toString(),
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
                            icons: Icons.shopping_bag_outlined,
                            title: 'Produk Saya',
                            onPressed: () {
                              Get.to(() => MyProductPage(toko: toko),
                                  arguments: toko.products);
                            }),
                        MenuItem(
                            icons: Icons.card_travel_outlined,
                            title: 'Pesanan Baru',
                            onPressed: () {
                              Get.toNamed('/newOrder-page');
                            }),
                        MenuItem(
                            icons: Icons.store_outlined,
                            title: 'Edit Toko',
                            onPressed: () {
                              Get.to(
                                () => EditStorePage(toko: toko),
                              );
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
