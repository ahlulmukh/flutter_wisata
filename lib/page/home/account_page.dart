import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/menu_item.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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

    showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: dangerColor,
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
                  const Icon(
                    Icons.exit_to_app,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Yakin ingin keluar?',
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 44,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff7d0404),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Batal',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                        width: 90,
                        child: TextButton(
                          onPressed: handleLogout,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff7d0404),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Keluar',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget header() {
      return AppBar(
        toolbarHeight: 60.0,
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
                height: 40,
              ),
              MenuItem(
                  icons: Icons.account_circle_outlined,
                  title: 'Edit Profil',
                  onPressed: () {
                    Get.toNamed('/edit-profile');
                  }),
              // MenuItem(
              //     icons: Icons.store,
              //     title: user.toko!.id != null ? 'Toko Saya' : "Buka Toko",
              //     // title: user.toko == null ? 'Registrasi Toko' : 'Toko Saya',
              //     onPressed: () {
              //       user.toko!.id != null
              //           ? Get.to(
              //               () => StorePage(
              //                     toko: user.toko as TokoModel,
              //                   ),
              //               arguments: user.toko?.id)
              //           : Get.toNamed('/registration-store');
              //     }),
              MenuItem(
                  icons: Icons.perm_device_information_sharp,
                  title: 'Informasi',
                  onPressed: () {
                    Get.toNamed('/information-store');
                  }),
              MenuItem(
                  icons: Icons.info_outline,
                  title: 'Panduan Aplikasi',
                  onPressed: () {
                    Get.toNamed('/guide-app');
                  }),
              Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: dangerColor,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: showSuccessDialog,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Logout',
                        style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                            color: dangerColor),
                      ),
                    ),
                  ),
                ],
              ),
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
                strokeWidth: 5.0,
              ))
            : ListView(
                children: [
                  header(),
                  content(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ));
  }
}
