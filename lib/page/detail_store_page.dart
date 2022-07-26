import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_product_category.dart';
import 'package:provider/provider.dart';

class DetailStorePage extends StatefulWidget {
  final TokoModel toko;

  const DetailStorePage({
    Key? key,
    required this.toko,
  }) : super(key: key);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState();
}

class _DetailStorePageState extends State<DetailStorePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      fetchMarket();
    });
  }

  fetchMarket() async {
    TokoProvider tokoProvider =
        Provider.of<TokoProvider>(context, listen: false);
    await tokoProvider.fetchToko(id: widget.toko.id!.toInt());
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
        centerTitle: true,
        toolbarHeight: 60.0,
        backgroundColor: whiteColor,
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
          'Detail Toko',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget getGridViewProduct() {
      if (tokoProvider.toko!.products.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              SvgPicture.asset(
                'assets/images/no_box.svg',
                width:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.75,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tidak ada produk',
                style:
                    greyTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              ),
              const SizedBox(
                height: 15,
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
              mainAxisExtent: 235, // here set custom Height You Want
            ),
            itemCount: tokoProvider.toko!.products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CardProductCategory(
                  product: tokoProvider.toko!.products[index] as ProductModel);
            },
          ),
        );
      }
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/photo_border.png'),
                  ),
                ),
                child: toko?.image == null || toko!.image!.isEmpty
                    ? Image.asset(
                        'assets/images/not_product.jpeg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: toko.image.toString(),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/not_product.jpeg',
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
                    'Desa ' + toko.village.toString(),
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Alamat',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              toko.address.toString(),
              textAlign: TextAlign.justify,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Deskripsi',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              toko.description.toString(),
              textAlign: TextAlign.justify,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Produk Toko',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(
              height: 12,
            ),
            getGridViewProduct()
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
                color: Colors.green,
              ),
            )
          : ListView(
              children: [
                header(),
                content(),
              ],
            ),
    );
  }
}
