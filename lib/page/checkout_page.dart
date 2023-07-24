import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/provider/checkout_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/button_loading.dart';
import 'package:flutter_tugas_akhir/widget/card_checkout.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  File? file;
  final _formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController(text: '');
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

  @override
  void dispose() {
    numberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);

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
                    'Berhasil melakukan\n pembelian',
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
                        Get.toNamed('/main-page');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Kembali',
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

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        List<CartModel> cartItems = cartProvider.cartList!;
        double totalPrice = cartProvider.totalPrice();
        int quantities = cartProvider.totalItems();
        print("Quantities: $quantities");
        if (await checkoutProvider.checkout(
          carts: cartProvider.cartList as List<CartModel>,
          nama: numberController.text,
          totalPrice: totalPrice,
          nameTicket: cartProvider.cartList![0].product?.name ?? '',
          quantities: quantities,
        )) {
          cartProvider.removeAllCart();
          showSuccessDialog();
          // Get.offNamedUntil('/checkout-success', (route) => true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: dangerColor,
              content: Text(
                'Gagal Checkout',
                style: whiteTextStyle.copyWith(fontWeight: bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
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
          'Detail Pembayaran',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget item() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      );
    }

    Widget listItems() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultRadius),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cartProvider.cartList!
                .map((carts) => CardCheckout(
                      cart: carts,
                    ))
                .toList()),
      );
    }

    Widget inputNama() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultRadius),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nama',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            color: whiteColor,
            child: TextFormField(
              controller: numberController,
              style: blackTextStyle.copyWith(fontSize: 14),
              showCursor: true,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              validator: (value) => value!.isEmpty ? 'Isikan Nama' : null,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 4),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 4),
                    borderRadius: BorderRadius.circular(14)),
                errorStyle: whiteTextStyle.copyWith(
                    fontWeight: bold, fontSize: 14, color: Colors.red),
                hintText: "Masukan Nama Lengkap",
                hintStyle: greyTextStyle,
                labelStyle:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                floatingLabelStyle:
                    blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blackColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ]),
      );
    }

    Widget detailPayment() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 10,
          left: defaultMargin,
          right: defaultMargin,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pembayaran',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Tiket',
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  cartProvider.totalItems().toString() + ' Item',
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              children: cartProvider.cartList!
                  .map((cart) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ticket',
                            style: whiteTextStyle.copyWith(fontWeight: medium),
                          ),
                          Text(
                            cart.product?.name ?? '',
                            style: whiteTextStyle.copyWith(fontWeight: medium),
                          )
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga',
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  currencyFormatter.format(cartProvider.totalPrice()),
                  overflow: TextOverflow.ellipsis,
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(color: whiteColor, height: 3.0),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  currencyFormatter.format(cartProvider.totalPrice()),
                  overflow: TextOverflow.ellipsis,
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget submitCheckout() {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: defaultRadius),
          child: CustomButton(
            title: 'Checkout Now',
            onPressed: handleCheckout,
          ));
    }

    return Scaffold(
        backgroundColor: backgroundColor1,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              header(),
              item(),
              listItems(),
              inputNama(),
              detailPayment(),
              isLoading == true ? const ButtonLoading() : submitCheckout(),
            ],
          ),
        ));
  }
}
