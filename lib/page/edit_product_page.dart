import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.done, size: 30),
          ),
        ],
        elevation: 0,
        title: Text(
          'Edit Produk',
          style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 20),
        ),
      );
    }

    Widget inputNameProduct() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Produk',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: blackColor, width: 2.0),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              height: 50,
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nama Produk',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget dropdownCategory() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(width: 2.0),
                  color: whiteColor),
              child: DropdownSearch<String>(
                  dropdownSearchDecoration: InputDecoration.collapsed(
                      enabled: true, hintText: '', hintStyle: greyTextStyle),
                  mode: Mode.MENU,
                  dropDownButton: const SizedBox(
                    width: 10,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                  items: const [
                    "Beras",
                    "Buah-Buahan",
                    "Kacang-Kacangan",
                    "Cabe-Cabean",
                    "Sayuran",
                    "Tebu",
                  ],
                  popupItemDisabled: (String s) => s.startsWith('T'),
                  onChanged: print,
                  selectedItem: "Pilih Kategori"),
            ),
          ],
        ),
      );
    }

    Widget inputWeigthProduct() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berat',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: blackColor, width: 2.0),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              height: 50,
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                      hintText: 'Berat',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputDescProduct() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 19,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi Produk',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: blackColor, width: 2.0),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              child: Center(
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Deskripsi Produk',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputStockProduct() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 19,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stock',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: blackColor, width: 2.0),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                      hintText: '0',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget uploadImage() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Gambar',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: blackColor, width: 2.0),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              height: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: greyColor, borderRadius: BorderRadius.circular(6)),
                  child: Text('Choose file',
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(fontWeight: bold)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin:
            EdgeInsets.only(top: 32, left: defaultMargin, right: defaultMargin),
        child: Column(children: [
          inputNameProduct(),
          dropdownCategory(),
          inputWeigthProduct(),
          inputStockProduct(),
          uploadImage(),
          inputDescProduct(),
        ]),
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
