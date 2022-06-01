import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:provider/provider.dart';

class EditProfilPage extends StatelessWidget {
  const EditProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context);
    UserModel? user = userProvider.user;

    TextEditingController controllerName =
        TextEditingController(text: user!.name);
    TextEditingController controllerUsername =
        TextEditingController(text: user.username);
    TextEditingController controllerEmail =
        TextEditingController(text: user.email);

    handleUpdateProfile() async {
      if (await userProvider.updateProfile(
        id: user.id,
        name: controllerName.text,
        username: controllerUsername.text,
        email: controllerEmail.text,
      )) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/main-page', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Update Profile',
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
            onPressed: handleUpdateProfile,
            icon: const Icon(Icons.done, size: 30, color: Colors.black),
          ),
        ],
        elevation: 0,
        title: Text(
          'Pengaturan Profil',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget inputName() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
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
                  controller: controllerName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Lengkap',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputUsername() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
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
                  controller: controllerUsername,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Username',
                      hintStyle: greyTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputEmail() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
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
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Email',
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
          top: 20,
        ),
        decoration: BoxDecoration(color: whiteColor),
        child: Column(
          children: [
            Container(
              height: 124,
              width: 124,
              margin: const EdgeInsets.only(bottom: 20, top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: user.profilePhotoUrl,
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
            inputName(),
            inputUsername(),
            inputEmail(),
            // inputPassword(),
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
