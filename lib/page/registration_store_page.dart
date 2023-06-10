import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/district_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/button_loading.dart';
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
  bool isLoading = false;
  File? file;
  String? desa;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameStoreController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController descStoreController = TextEditingController(text: '');
  TextEditingController nameAccountController = TextEditingController(text: '');
  TextEditingController numberAccountController =
      TextEditingController(text: '');

  @override
  void dispose() {
    nameStoreController.clear();
    addressController.clear();
    descStoreController.clear();
    nameAccountController.clear();
    numberAccountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserModel? user = authProvider.user;

    handleCreateToko() async {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        if (await tokoProvider.createToko(
          usersId: user!.id!.toInt(),
          nameStore: nameStoreController.text,
          village: desa.toString(),
          address: addressController.text,
          description: descStoreController.text,
          accountName: nameAccountController.text,
          accountNumber: numberAccountController.text,
          image: file ?? File(''),
        )) {
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
      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        toolbarHeight: 60.0,
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
            setState(() {
              file = File(pickedFile.path);
            });
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
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nama Toko',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: nameStoreController,
            style: blackTextStyle.copyWith(fontSize: 14),
            showCursor: true,
            validator: (value) => value!.isEmpty ? 'Isikan Nama Toko' : null,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
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
              hintText: "Masukan Nama Toko",
              hintStyle: greyTextStyle,
              labelStyle:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      );
    }

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
            SizedBox(
              child: DropdownSearch<DistrictModel>(
                validator: (value) =>
                    value?.nama.isEmpty == null ? 'Pilih Desa' : null,
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
                dropdownSearchDecoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.circular(14)),
                  errorStyle: whiteTextStyle.copyWith(
                      fontWeight: bold, fontSize: 14, color: Colors.red),
                  hintStyle: greyTextStyle,
                  labelStyle:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(10)),
                  floatingLabelStyle: blackTextStyle.copyWith(
                      fontSize: 18, fontWeight: semiBold),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blackColor, width: 3),
                    borderRadius: BorderRadius.circular(10),
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
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Alamat Lengkap',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: addressController,
            style: blackTextStyle.copyWith(fontSize: 14),
            showCursor: true,
            validator: (value) => value!.isEmpty ? 'Isikan Alamat Toko' : null,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            maxLines: 3,
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
              hintText: "Masukan Alamat Toko",
              hintStyle: greyTextStyle,
              labelStyle:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      );
    }

    Widget inputDescStore() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Deskripsi Toko',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: descStoreController,
            style: blackTextStyle.copyWith(fontSize: 14),
            showCursor: true,
            maxLines: 3,
            validator: (value) =>
                value!.isEmpty ? 'Isikan Deskripsi Toko' : null,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
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
              hintText: "Masukan Deskripsi Toko",
              hintStyle: greyTextStyle,
              labelStyle:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      );
    }

    Widget inputNameBank() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nama Rekening',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: nameAccountController,
            style: blackTextStyle.copyWith(fontSize: 14),
            showCursor: true,
            validator: (value) =>
                value!.isEmpty ? 'Isikan Nama Rekening' : null,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
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
              hintText: "Masukan Deskripsi Toko",
              hintStyle: greyTextStyle,
              labelStyle:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      );
    }

    Widget inputNumberBank() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nomor Rekening',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: numberAccountController,
            style: blackTextStyle.copyWith(fontSize: 14),
            showCursor: true,
            validator: (value) =>
                value!.isEmpty ? 'Isikan Nomor Rekening' : null,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
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
              hintText: "Masukan Nomor Rekening",
              hintStyle: greyTextStyle,
              labelStyle:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      );
    }

    Widget submitButton() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
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
            dropdownVillage(),
            inputAddressStore(),
            inputDescStore(),
            inputNameBank(),
            inputNumberBank(),
            isLoading == true ? const ButtonLoading() : submitButton(),
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
            content(),
          ],
        ),
      ),
    );
  }
}
