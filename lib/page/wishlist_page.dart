import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_wishlist.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Wishlist',
          style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 20),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: const [
            CardWishlist(),
            CardWishlist(),
            CardWishlist(),
          ],
        ),
      );
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
