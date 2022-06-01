import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/district_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/district_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:provider/provider.dart';

class RegistrationStorePage extends StatefulWidget {
  const RegistrationStorePage({Key? key}) : super(key: key);

  @override
  State<RegistrationStorePage> createState() => _RegistrationStorePageState();
}

class _RegistrationStorePageState extends State<RegistrationStorePage> {
  @override
  void initState() {
    super.initState();
    getDistrict();
  }

  Future<void> getDistrict() async {
    Provider.of<DistrictProvider>(context, listen: false).getdistricts();
  }

  @override
  Widget build(BuildContext context) {
    DistrictProvider districtProvider = Provider.of<DistrictProvider>(context);

    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? usersId = authProvider.user;

    TextEditingController nameStoreController = TextEditingController(text: '');
    TextEditingController nameVillageController =
        TextEditingController(text: '');
    TextEditingController addressController = TextEditingController(text: '');
    TextEditingController descStoreController = TextEditingController(text: '');
    TextEditingController nameAccountController =
        TextEditingController(text: '');
    TextEditingController numberAccountController =
        TextEditingController(text: '');

    handleCreateToko() async {
      if (await tokoProvider.createToko(
        usersId: usersId!.id,
        nameStore: nameStoreController.text,
        village: nameVillageController.text,
        address: addressController.text,
        description: descStoreController.text,
        accountName: nameAccountController.text,
        accountNumber: int.parse(numberAccountController.text).toInt(),
      )) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/store-page', (route) => false);
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
          'Registrasi Toko',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
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

    Widget inputNameVillage() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Desa',
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
                  controller: nameVillageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nama Desa',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    // Widget dropdownVillage() {
    //   return Container(
    //     width: double.infinity,
    //     margin: const EdgeInsets.only(bottom: 19),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Desa',
    //           style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
    //         ),
    //         const SizedBox(
    //           height: 6,
    //         ),
    //         Container(
    //             padding: const EdgeInsets.symmetric(horizontal: 14),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(defaultRadius),
    //                 border: Border.all(width: 2.0),
    //                 color: whiteColor),
    //             child: Consumer<DistrictProvider>(
    //               builder: (context, provider, child) {
    //                 return DropdownButton(
    //                     value: provider.district,
    //                     items: provider.district.map((item) {
    //                       return DropdownMenuItem(
    //                           value: item, child: Text(item!.nama));
    //                     }).toList(),
    //                     onChanged: (value) {
    //                       setState(() {

    //                       });
    //                     });
    //               },
    //             )),
    //       ],
    //     ),
    //   );
    // }

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
            inputNameStore(),
            inputNameVillage(),
            // dropdownVillage(),
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
