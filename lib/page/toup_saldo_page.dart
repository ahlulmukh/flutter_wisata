import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/topup_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/button_loading.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({Key? key}) : super(key: key);

  @override
  State<SaldoPage> createState() => _SaldoPagePageState();
}

class _SaldoPagePageState extends State<SaldoPage> {
  double saldo = 0.0;
  bool isPending = false;
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
    TopupProvider topupProvider = Provider.of<TopupProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        if (await topupProvider.topup(
          saldo: numberController.text,
          image: file ?? File(""),
        )) {
          Get.toNamed('/main-page');
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
          'Top Up Saldo',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
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
              'Top Up Saldo',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
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
                  currencyFormatter.format(saldo),
                  overflow: TextOverflow.ellipsis,
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget inputNumber() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultRadius),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo ',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              color: whiteColor,
              child: Row(
                children: [
                  Text(
                    'Rp. ',
                    style: blackTextStyle.copyWith(fontSize: 14),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: numberController,
                      style: blackTextStyle.copyWith(fontSize: 14),
                      showCursor: true,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          saldo = double.tryParse(value) ?? 0.0;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Isikan saldo yang diinginkan';
                        } else if (saldo <= 0.0) {
                          return 'Saldo harus lebih dari 0';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 4),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        errorStyle: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 14,
                          color: Colors.red,
                        ),
                        hintText: "Masukkan Saldo",
                        hintStyle: greyTextStyle,
                        labelStyle: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blackColor, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
            file = File(pickedFile.path);
            setState(() {});
          } else {
            return;
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

    Widget submitCheckout() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: defaultRadius),
        child: Column(
          children: [
            CustomButton(
              title: 'Top Up',
              onPressed: handleCheckout,
            ),
            const SizedBox(height: 8), // Jarak antara tombol dan teks catatan
            const Text(
              'Catatan: Harap melakukan pembayaran ke nomor rek 000000 atas Nama Fira Fadilah sebelum melakukan transaksi, karena jika slip pembayaran tidak valid maka status top up akan gagal. Terima Kasih',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor1,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              header(),
              inputNumber(),
              uploadImage(),
              detailPayment(),
              isLoading == true ? const ButtonLoading() : submitCheckout(),
            ],
          ),
        ));
  }
}
