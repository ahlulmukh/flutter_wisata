import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
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
          'Keranjang',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget submitCheckout() {
      return TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            backgroundColor: backgroundColor3),
        onPressed: () {},
        child: Text(
          'Bayar',
          style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 15),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CardCart(),
            const CardCart(),
            const CardCart(),
            const SizedBox(
              height: 10,
            ),
            submitCheckout(),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor1,
        body: ListView(
          children: [
            header(),
            content(),
          ],
        ));
  }
}
