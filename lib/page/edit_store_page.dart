// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/district_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/page/store_page.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditStorePage extends StatefulWidget {
  final TokoModel toko;
  const EditStorePage({Key? key, required this.toko}) : super(key: key);

  @override
  State<EditStorePage> createState() => _EditStorePageState();
}

class _EditStorePageState extends State<EditStorePage> {
  bool isLoading = false;
  File? file;
  String? desa;

  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    TokoModel? toko = tokoProvider.toko;

    TextEditingController nameStoreController =
        TextEditingController(text: toko!.nameStore);
    TextEditingController addressStore =
        TextEditingController(text: toko.address);
    TextEditingController descStore =
        TextEditingController(text: toko.description);
    TextEditingController nameAccount =
        TextEditingController(text: toko.accountName);
    TextEditingController numberAccount =
        TextEditingController(text: toko.accountNumber.toString());

    submitUpdateToko() async {
      setState(() {
        isLoading = true;
      });
      if (await tokoProvider.updateProfileToko(
          toko.id!.toInt(),
          toko.usersId.toString(),
          nameStoreController.text,
          desa.toString(),
          addressStore.text,
          descStore.text,
          nameAccount.text,
          numberAccount.text.toString(),
          image: file!)) {
        Get.to(
          () => StorePage(toko: toko),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Update Profile Toko',
              style: whiteTextStyle.copyWith(fontWeight: bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

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
        actions: [
          IconButton(
            onPressed: submitUpdateToko,
            icon: isLoading
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.black,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.done,
                    size: 30,
                    color: Colors.black,
                  ),
          ),
        ],
        elevation: 0,
        title: Text(
          'Edit Toko',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget editPhoto() {
      return GestureDetector(
        onTap: () async {
          XFile? photo =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (photo == null) return;
          if (photo.path == null) {
            return;
          }
          file = File(photo.path);
          setState(() {});
        },
        child: Container(
            height: 130,
            width: 130,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/photo_border.png'),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 20, top: 20),
            child: (file != null)
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(file!), fit: BoxFit.cover)),
                  )
                : Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(toko.image.toString()),
                            fit: BoxFit.cover)),
                  )),
      );
    }

    Widget inputNameStore() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Toko',
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
                  controller: nameStoreController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nama Toko',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget dropdownVillage() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            bottom: 19, left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Desa',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(width: 2.0),
                  color: whiteColor),
              child: DropdownSearch<DistrictModel>(
                onChanged: (DistrictModel? district) {
                  desa = district!.nama;
                },
                dropdownBuilder: (context, select) => select != null
                    ? Text(
                        select.nama,
                        style: blackTextStyle.copyWith(fontWeight: medium),
                      )
                    : Text(
                        toko.village.toString(),
                        style: greyTextStyle.copyWith(fontWeight: semiBold),
                      ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item.nama,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  ),
                ),
                onFind: (String? filter) async {
                  List<DistrictModel> districts = [];
                  var response = await Dio().get(Service.apiUrl + '/districts',
                      queryParameters: {"filter": filter});
                  if (response.statusCode == 200) {
                    List allDistrictsBaktiya = response.data['data'];
                    for (var element in allDistrictsBaktiya) {
                      districts.add(
                        DistrictModel(
                          id: element['id'],
                          nama: element['nama'],
                        ),
                      );
                    }
                  } else {
                    throw Exception('Gagal ambil data');
                  }
                  return districts;
                },
              ),
            )
          ],
        ),
      );
    }

    Widget inputAddressStore() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            bottom: 19, left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Lengkap',
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
                  controller: addressStore,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Alamat Lengkap',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputDescStore() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            bottom: 19, left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi Toko',
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
                  controller: descStore,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Deskripsi Toko',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputNameAccount() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            bottom: 19, left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Rekening',
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
                  controller: nameAccount,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nomor Rekening',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputNumberBank() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            bottom: 19, left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Rekening',
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
                  controller: numberAccount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nomor Rekening',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 40,
        ),
        child: Column(
          children: [
            editPhoto(),
            inputNameStore(),
            dropdownVillage(),
            inputAddressStore(),
            inputDescStore(),
            inputNameAccount(),
            inputNumberBank(),
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
      ),
    );
  }
}
