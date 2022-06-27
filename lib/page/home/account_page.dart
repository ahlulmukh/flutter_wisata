import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/page/store_page.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/menu_item.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfil();
    // fetchMarket();
  }

  getProfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getProfile();
    setState(() {
      isLoading = false;
    });
  }

  handleLogout() async {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Get.offAllNamed('/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    Widget header() {
      return AppBar(
        centerTitle: true,
        toolbarHeight: 70.0,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Profil',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: whiteColor),
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Container(
                height: 130,
                width: 130,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/photo_border.png'),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                child: user?.profilePhotoPath == null
                    ? Image.asset('assets/images/user.png')
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: user!.profilePhotoPath.toString(),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/user.png',
                              )),
                        ),
                      ),
              ),
              Column(children: [
                Text(
                  user!.name.toString(),
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                Text(
                  user.email.toString(),
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ]),
              const SizedBox(
                height: 60,
              ),
              MenuItem(
                  title: 'Edit Profil',
                  onPressed: () {
                    Get.toNamed('/edit-profile');
                  }),
              MenuItem(title: 'Transaksi', onPressed: () {}),
              MenuItem(
                  // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
                  title:
                      user.toko!.id != null ? 'Toko Saya' : "Registrasi Toko",
                  // title: user.toko == null ? 'Registrasi Toko' : 'Toko Saya',
                  onPressed: () {
                    // ignore: unnecessary_null_comparison
                    user.toko!.id != null
                        ? Get.to(
                            () => StorePage(
                                  toko: user.toko as TokoModel,
                                ),
                            arguments: user.toko?.id)
                        : Get.toNamed('/registration-store');
                  }),
              MenuItem(
                  title: 'Informasi',
                  onPressed: () {
                    Get.toNamed('/information-store');
                  }),
              GestureDetector(
                onTap: handleLogout,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Logout',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold, color: dangerColor),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor1,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: secondaryColor,
                strokeWidth: 8.0,
              ))
            : ListView(
                children: [
                  header(),
                  content(),
                ],
              ));
  }
}
