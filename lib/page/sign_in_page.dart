import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    print(prefs.getString('token'));
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TextEditingController emailCon = TextEditingController(text: '');
    TextEditingController passCon = TextEditingController(text: '');
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    handleSignIn() async {
      if (_formKey.currentState!.validate()) {
        if (await authProvider.login(
            email: emailCon.text, password: passCon.text)) {
          Get.offAllNamed('/main-page',
              arguments: pageProvider.currentIndex = 0);
        } else {
          Get.snackbar('Gagal Login', "Silahkan isi dengan benar",
              colorText: Colors.white,
              backgroundColor: Colors.red[900],
              icon: const Icon(
                Icons.error,
                size: 25,
                color: Colors.white,
              ));
        }
      }
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Text(
          'MARKETTANI',
          style: whiteTextStyle.copyWith(
              fontSize: 36, letterSpacing: 7.2, fontWeight: bold),
        ),
      );
    }

    Widget inputEmail() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: whiteTextStyle.copyWith(fontWeight: medium),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              height: 50,
              child: Center(
                child: TextFormField(
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukan email';
                    }
                    return null;
                  }),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCon,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Email',
                      hintStyle: greyTextStyle.copyWith(fontSize: 12)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputPassword() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: whiteTextStyle.copyWith(fontWeight: medium),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              height: 50,
              child: Center(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukan password';
                    }
                    return null;
                  },
                  controller: passCon,
                  obscureText: true,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Password',
                      hintStyle: greyTextStyle.copyWith(fontSize: 12)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget submitButton() {
      return CustomButton(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        title: 'Masuk',
        onPressed: handleSignIn,
      );
    }

    Widget footer() {
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun?',
              style: whiteTextStyle,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/sign-up');
              },
              child: Text(
                ' Daftar',
                style: whiteTextStyle.copyWith(
                    color: lightColor, fontWeight: bold),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            header(),
            inputEmail(),
            inputPassword(),
            submitButton(),
            const Spacer(),
            footer(),
            const SizedBox(
              height: 13,
            )
          ],
        ),
      ),
    );
  }
}
