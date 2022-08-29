import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/wishlist_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_wishlist.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    Widget header() {
      return AppBar(
        toolbarHeight: 60.0,
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
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Image.asset(
                      'assets/wishlist.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tidak ada wishlist',
                      textAlign: TextAlign.center,
                      style: greyTextStyle.copyWith(
                          fontSize: 22, fontWeight: semiBold),
                    )
                  ],
                )
              : Column(
                  children: wishlistProvider.wishlist
                      .map((wishlist) => CardWishlist(product: wishlist!))
                      .toList(),
                ));
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
