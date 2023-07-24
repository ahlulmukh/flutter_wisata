// ignore_for_file: unnecessary_cast, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/page/home/main_page.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/provider/wishlist_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class DetailProductPage extends StatefulWidget {
  final ProductModel product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isWishlist = false;
  bool isLoading = true;
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

  fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getProfile();
  }

  Future fetchProduct() async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.getProductId(id: widget.product.id!.toInt());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
    fetchUser();
    // fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserModel? user = authProvider.user;

    Future fetchCart() async {
      CartProvider cartProvider = Provider.of<CartProvider>(context);
      await cartProvider.getCart(id: widget.product.id.toString());
    }

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icon_success.png',
                    width: 100,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Berhasil',
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Berhasil ditambahkan\n ke Book',
                    textAlign: TextAlign.center,
                    style: whiteTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/cart-page');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Book',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget detailImage() {
      return SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height * 0.6
            : 338,
        child: widget.product.image!.isEmpty == true
            ? Image.asset(
                'assets/images/not_product.jpeg',
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
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
      );
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 17),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: greyColor.withOpacity(0.7),
            child: Icon(
              Icons.chevron_left,
              color: whiteColor,
              size: 30,
            ),
          ),
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
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name.toString(),
                      style: blackTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: bold),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  FutureBuilder(
                    future: fetchCart(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: secondaryColor,
                          ),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation(
                                    whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return GestureDetector(
                          onTap: () async {
                            if (cartProvider.cart != null) {
                              cartProvider.addtoCart(
                                userId: user!.id.toString(),
                                productId: widget.product.id!.toString(),
                                quantity: cartProvider.cart!.quantity,
                              );
                              showSuccessDialog();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: secondaryColor,
                            ),
                            width: 150,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: whiteColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Keranjang',
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Text('${snapshot.hasError}');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormatter.format(widget.product.price),
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
                GestureDetector(
                  onTap: () async {
                    wishlistProvider.setProduct(widget.product);
                    if (wishlistProvider.isWishlist(widget.product)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'Lihat',
                            onPressed: () => Get.to(() => const MainPage(),
                                arguments: pageProvider.currentIndex = 2),
                            textColor: whiteColor,
                          ),
                          backgroundColor: secondaryColor,
                          content: Text(
                            'Berhasil ditambah ke wishlist',
                            style: whiteTextStyle.copyWith(fontWeight: bold),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: dangerColor,
                          content: Text(
                            'Berhasil dihapus dari wishlist',
                            style: whiteTextStyle.copyWith(fontWeight: bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    wishlistProvider.isWishlist(widget.product)
                        ? 'assets/icon_love_on.png'
                        : 'assets/icon_love_off.png',
                    width: 50,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.product.category!.name.toString(),
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lokasi',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.product.lokasi.toString(),
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Deskripsi Tempat Wisata',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product.description.toString(),
              textAlign: TextAlign.justify,
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(height: 14),
            Divider(
              color: greyColor,
              thickness: 4.0,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    }

    Widget shimmerImage() {
      return Container(
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height * 0.6
            : 338,
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
            ),
          ),
        ),
      );
    }

    Widget shimmerProduct() {
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
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: CircleAvatar(
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 150,
                        height: 25,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 150,
                        height: 25,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 120,
                        height: 35,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
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
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: isLoading
          ? ListView(
              children: [
                Stack(
                  children: [
                    shimmerImage(),
                    shimmerProduct(),
                  ],
                )
              ],
            )
          : ListView(
              children: [
                Stack(
                  children: [
                    detailImage(),
                    header(),
                    descriptionProduct(),
                  ],
                ),
              ],
            ),
    );
  }
}
