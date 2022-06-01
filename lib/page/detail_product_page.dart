import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/page/detail_store_page.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailProductPage extends StatefulWidget {
  final ProductModel product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isWishlist = false;
  bool isLoading = true;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  fetchProduct() async {
    ProductProvider productProvider = Provider.of(context, listen: false);
    await productProvider.getProductId(id: widget.product.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    ProductModel? product = productProvider.getProduct;

    Widget detailImage() {
      return SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height * 0.6
            : 338,
        child: product?.image == null || product!.image!.isEmpty
            ? Image.asset(
                'assets/images/not_product.jpeg',
                fit: BoxFit.cover,
              )
            : Hero(
                tag: widget.product.image.toString(),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.product.image.toString(),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/not_product.jpeg',
                    ),
                  ),
                ),
              ),
      );
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor: greyColor.withOpacity(0.4),
                child: Icon(
                  Icons.chevron_left,
                  color: whiteColor,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget descriptionProduct() {
      return Container(
        margin: const EdgeInsets.only(top: 310),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product!.name,
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icon_pengurangan.png',
                      width: 26,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '1',
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      'assets/icon_penambahan.png',
                      width: 26,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormatter.format(product.price),
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isWishlist = !isWishlist;
                    });

                    if (!isWishlist) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: dangerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(20),
                          ),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          content: Text(
                            'Berhasil dihapus dari wishlist',
                            textAlign: TextAlign.center,
                            style: whiteTextStyle.copyWith(fontWeight: bold),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(20),
                          ),
                          backgroundColor: backgroundColor2,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          content: Text(
                            'Berhasil ditambah ke wishlist',
                            textAlign: TextAlign.center,
                            style: whiteTextStyle.copyWith(fontWeight: bold),
                          ),
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    isWishlist
                        ? 'assets/icon_love_on.png'
                        : 'assets/icon_love_off.png',
                    width: 50,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              product.description,
              textAlign: TextAlign.justify,
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: Image.asset(
                    "assets/img_store.png",
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.market!.nameStore.toString(),
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      product.market!.village.toString(),
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10)),
                          backgroundColor: backgroundColor3,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailStorePage(
                                  toko: product.market as TokoModel),
                            ));
                      },
                      child: Text('Kunjungi Toko',
                          style: whiteTextStyle.copyWith(fontWeight: bold)),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(
              color: greyColor,
              thickness: 4.0,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Rp. 30.000',
                  style: greyTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
                const Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin, vertical: 8),
                        backgroundColor: backgroundColor3),
                    onPressed: () {},
                    child: Text(
                      'Tambah dalam keranjang',
                      style: whiteTextStyle.copyWith(fontWeight: bold),
                    ))
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 10.0,
                color: Colors.green,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  detailImage(),
                  header(),
                  descriptionProduct(),
                ],
              ),
            ),
    );
  }
}
