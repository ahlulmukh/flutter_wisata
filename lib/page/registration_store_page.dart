// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/district_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/page/store_page.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegistrationStorePage extends StatefulWidget {
  const RegistrationStorePage({Key? key}) : super(key: key);

  @override
  State<RegistrationStorePage> createState() => _RegistrationStorePageState();
}

class _RegistrationStorePageState extends State<RegistrationStorePage> {
  File? file;
  String? desa;

  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserModel? user = authProvider.user;

    TextEditingController nameStoreController = TextEditingController(text: '');
    TextEditingController addressController = TextEditingController(text: '');
    TextEditingController descStoreController = TextEditingController(text: '');
    TextEditingController nameAccountController =
        TextEditingController(text: '');
    TextEditingController numberAccountController =
        TextEditingController(text: '');

    handleCreateToko() async {
      if (await tokoProvider.createToko(
          usersId: user!.id,
          nameStore: nameStoreController.text,
          village: desa.toString(),
          address: addressController.text,
          description: descStoreController.text,
          accountName: nameAccountController.text,
          accountNumber: int.parse(numberAccountController.text).toInt(),
          image: file!)) {
        Get.off(() => StorePage(toko: user.toko as TokoModel));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Buat Toko',
              style: whiteTextStyle.copyWith(fontWeight: bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget header() {
      return AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Get.offNamed('/main-page',
                  arguments: pageProvider.currentIndex = 3);
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
          'Registrasi Toko',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget addPhoto() {
      return GestureDetector(
        onTap: () async {
          XFile? pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            file = File(pickedFile.path);
            setState(() {});
          }
        },
        child: Container(
          width: 130,
          height: 130,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/photo_border.png'))),
          child: (file != null)
              ? Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(file!), fit: BoxFit.cover)),
                )
              : Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/photo.png'),
                          fit: BoxFit.cover)),
                ),
        ),
      );
    }

    Widget inputNameStore() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
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

    // Widget inputNameVillage() {
    //   return Container(
    //     width: double.infinity,
    //     margin: const EdgeInsets.only(bottom: 19),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Nama Desa',
    //           style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
    //         ),
    //         const SizedBox(
    //           height: 6,
    //         ),
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    //           decoration: BoxDecoration(
    //               border: Border.all(color: blackColor, width: 2.0),
    //               color: whiteColor,
    //               borderRadius: BorderRadius.circular(defaultRadius)),
    //           height: 50,
    //           child: Center(
    //             child: TextFormField(
    //               controller: nameVillageController,
    //               keyboardType: TextInputType.text,
    //               decoration: InputDecoration.collapsed(
    //                   hintText: 'Masukan Nama Desa',
    //                   hintStyle: greyTextStyle.copyWith(
    //                       fontWeight: semiBold, fontSize: 13)),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }

    Widget dropdownVillage() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
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
                        'Belum memilih desa',
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
        margin: const EdgeInsets.only(bottom: 19),
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
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
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
        margin: const EdgeInsets.only(bottom: 19),
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
                  controller: descStoreController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
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

    Widget inputNameBank() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
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
                  controller: nameAccountController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nama Rekening',
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
        margin: const EdgeInsets.only(bottom: 19),
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
                  controller: numberAccountController,
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

    Widget submitButton() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: CustomButton(
          title: 'Daftar Toko',
          onPressed: handleCreateToko,
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            addPhoto(),
            inputNameStore(),
            // inputNameVillage(),
            dropdownVillage(),
            inputAddressStore(),
            inputDescStore(),
            inputNameBank(),
            inputNumberBank(),
            submitButton(),
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
