import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_product_store.dart';
import 'package:provider/provider.dart';

class DetailStorePage extends StatefulWidget {
  final TokoModel toko;
  static String routeName = '/detail-store-page';
  const DetailStorePage({Key? key, required this.toko}) : super(key: key);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState();
}

class _DetailStorePageState extends State<DetailStorePage> {
  bool isLoading = true;

  fetchMarket() async {
    TokoProvider tokoProvider =
        Provider.of<TokoProvider>(context, listen: false);
    await tokoProvider.fetchToko(id: widget.toko.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMarket();
  }

  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    TokoModel? toko = tokoProvider.toko;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return AppBar(
        centerTitle: true,
        toolbarHeight: 70.0,
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
        return SizedBox(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 16,
              mainAxisExtent: 260, // here set custom Height You Want
            ),
            itemCount: tokoProvider.toko!.products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CardProductStore(
                  product: productProvider.product[index] as ProductModel);
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
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(100),
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
                    toko!.nameStore,
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
                    toko.village,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Deskripsi',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              toko.description,
              textAlign: TextAlign.justify,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Produk',
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
              child: CircularProgressIndicator(),
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
