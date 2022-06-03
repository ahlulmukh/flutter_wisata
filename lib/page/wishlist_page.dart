import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/provider/wishlist_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_wishlist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  checkIdProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('wishlist'));
  }

  @override
  void initState() {
    super.initState();
    checkIdProduct();
  }

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    Widget header() {
      return AppBar(
        centerTitle: true,
        toolbarHeight: 70.0,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Wishlist',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget content() {
      return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: wishlistProvider.wishlist.isEmpty
              ? Center(
                  child: Text(
                  'Tidak ada list produk',
                  style: greyTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 18,
                  ),
                ))
              : Column(
                  children: wishlistProvider.wishlist
                      .map((wishlist) => CardWishlist(product: wishlist!))
                      .toList(),
                ));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        body: ListView(
          children: [
            header(),
            content(),
          ],
        ),
      ),
    );
  }
}
