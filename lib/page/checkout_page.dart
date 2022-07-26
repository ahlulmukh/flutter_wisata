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
import 'package:image_picker/image_picker.dart';
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
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController numberController = TextEditingController(text: '');
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

  @override
  void dispose() {
    addressController.clear();
    numberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);

    int index = cartProvider.cartList!
        .indexWhere((element) => element.id == element.id);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        if (await checkoutProvider.checkout(
          address: addressController.text,
          carts: cartProvider.cartList as List<CartModel>,
          phone: numberController.text,
          image: file!,
          totalPrice: cartProvider.totalPrice(),
          storeId: cartProvider.cartList![index].product!.market!.id.toString(),
        )) {
          cartProvider.removeAllCart();
          Get.offNamedUntil('/checkout-success', (route) => false);
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

    Widget inputAddress() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultRadius),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Alamat Lengkap',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            color: whiteColor,
            child: TextFormField(
              controller: addressController,
              style: blackTextStyle.copyWith(fontSize: 14),
              showCursor: true,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              maxLines: 3,
              validator: (value) => value!.isEmpty ? 'Isikan Alamat' : null,
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
                hintText: "Masukan Alamat Lengkap",
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

    Widget inputNumber() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultRadius),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'No Telp',
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
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              validator: (value) => value!.isEmpty ? 'Isikan No Telp' : null,
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
                hintText: "Masukan Nomor Telp",
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

    Widget detailMarket() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: blackColor),
            color: whiteColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartProvider.cartList![index].product!.market!.nameStore
                  .toString(),
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Nama Rekening : ' +
                  cartProvider.cartList![index].product!.market!.accountName
                      .toString(),
              style: blackTextStyle.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Nomor Rekening : ' +
                  cartProvider.cartList![index].product!.market!.accountNumber
                      .toString(),
              style: blackTextStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget uploadImage() {
      return GestureDetector(
        onTap: () async {
          XFile? pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              file = File(pickedFile.path);
            });
          }
        },
        child: (file != null)
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: defaultRadius),
                width: double.infinity,
                height: 145,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(file!), fit: BoxFit.cover),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: defaultRadius),
                width: double.infinity,
                height: 145,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/img_upload.png'),
                        fit: BoxFit.contain)),
              ),
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
                  'Jumlah Produk',
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
              inputAddress(),
              inputNumber(),
              detailMarket(),
              uploadImage(),
              detailPayment(),
              isLoading == true ? const ButtonLoading() : submitCheckout(),
            ],
          ),
        ));
  }
}
