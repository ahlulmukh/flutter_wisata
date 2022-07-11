// ignore_for_file: avoid_unnecessary_containers, unrelated_type_equality_checks, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_cart.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    await Provider.of<CartProvider>(context, listen: false).getCartList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget content() {
      return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: cartProvider.cartList!
                .map((cart) => CardCart(cart: cart))
                .toList(),
          ));
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, color: greyColor, size: 90),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Tidak ada Keranjang',
              style: greyTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget customBottomNav() {
      return Container(
        padding: const EdgeInsets.only(top: 12),
        height: 70,
        child: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/checkout');
                },
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Checkout',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60.0,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Get.back();
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
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: secondaryColor,
              strokeWidth: 8.0,
            ))
          : cartProvider.cartList!.length == 0
              ? emptyCart()
              : content(),
      bottomNavigationBar: cartProvider.cartList!.length == 0
          ? const SizedBox()
          : customBottomNav(),
    );
  }
}
