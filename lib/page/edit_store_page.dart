import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:provider/provider.dart';

class EditStorePage extends StatefulWidget {
  const EditStorePage({Key? key}) : super(key: key);

  @override
  State<EditStorePage> createState() => _EditStorePageState();
}

class _EditStorePageState extends State<EditStorePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TokoProvider tokoProvider = Provider.of<TokoProvider>(context);
    TokoModel? toko = authProvider.user!.toko;

    TextEditingController nameStoreController =
        TextEditingController(text: toko!.nameStore);
    TextEditingController nameVillageStore =
        TextEditingController(text: toko.village);
    TextEditingController addressStore =
        TextEditingController(text: toko.address);
    TextEditingController descStore =
        TextEditingController(text: toko.description);
    TextEditingController nameAccount =
        TextEditingController(text: toko.accountName);
    TextEditingController numberAccount =
        TextEditingController(text: toko.accountNumber.toString());

    submitUpdateToko() async {
      if (await tokoProvider.updateProfileToko(
          id: toko.id,
          usersId: toko.usersId,
          nameStore: nameStoreController.text,
          village: nameVillageStore.text,
          address: addressStore.text,
          description: descStore.text,
          accountName: nameAccount.text,
          accountNumber: int.parse(numberAccount.text).toInt())) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/store-page', (route) => false);
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
            icon: const Icon(
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

    Widget inputVillageStore() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 19),
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
                  controller: nameVillageStore,
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
    //     margin: EdgeInsets.only(
    //         bottom: 19, left: defaultMargin, right: defaultMargin),
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
    //           padding: const EdgeInsets.symmetric(horizontal: 14),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(defaultRadius),
    //               border: Border.all(width: 2.0),
    //               color: whiteColor),
    //           child: DropdownSearch<String>(
    //               dropdownSearchDecoration: InputDecoration.collapsed(
    //                   hintText: '', hintStyle: greyTextStyle),
    //               mode: Mode.MENU,
    //               dropDownButton: const SizedBox(
    //                   width: 10,
    //                   child: Icon(Icons.keyboard_arrow_down, size: 30)),
    //               items: const [
    //                 "Brazil",
    //                 "Italia (Disabled)",
    //                 "Tunisia",
    //                 'Canada'
    //               ],
    //               popupItemDisabled: (String s) => s.startsWith('I'),
    //               onChanged: print,
    //               selectedItem: "Pilih Desa"),
    //         ),
    //       ],
    //     ),
    //   );
    // }

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
            // GestureDetector(
            //   onTap: () async {
            //     PickedFile pickedFile =
            //         await ImagePicker().getImage(source: ImageSource.gallery);
            //     if (pickedFile != null) {
            //       pictureFile = File(pickedFile.path);
            //       setState(() {});
            //     }
            //   },
            //   child: Container(
            //     width: 110,
            //     height: 110,
            //     margin: const EdgeInsets.only(top: 26),
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage('assets/photo_border.png'))),
            //     child: (pictureFile != null)
            //         ? Container(
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 image: DecorationImage(
            //                     image: FileImage(pictureFile),
            //                     fit: BoxFit.cover)),
            //           )
            //         : Container(
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 image: DecorationImage(
            //                     image: AssetImage('assets/photo.png'),
            //                     fit: BoxFit.cover)),
            //           ),
            //   ),
            // ),
            inputNameStore(),
            inputVillageStore(),
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
