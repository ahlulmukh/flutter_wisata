import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    TextEditingController nameCont = TextEditingController(text: '');
    TextEditingController usernameCont = TextEditingController(text: '');
    TextEditingController emailCont = TextEditingController(text: '');
    TextEditingController passwordCont = TextEditingController(text: '');

    handleSignUp() async {
      if (await authProvider.register(
          name: nameCont.value.text,
          username: usernameCont.value.text,
          email: emailCont.value.text,
          password: passwordCont.value.text)) {
        Navigator.pushNamed(context, '/main-page');
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

    Widget inputName() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Lengkap',
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
                  keyboardType: TextInputType.text,
                  controller: nameCont,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Nama Lengkap',
                      hintStyle: greyTextStyle.copyWith(fontSize: 12)),
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
            left: defaultMargin, right: defaultMargin, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
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
                  controller: usernameCont,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Masukan Username',
                      hintStyle: greyTextStyle.copyWith(fontSize: 12)),
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
                  controller: emailCont,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: passwordCont,
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
        title: 'Buat Akun',
        onPressed: handleSignUp,
      );
    }

    Widget footer() {
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
              style: whiteTextStyle,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                ' Masuk',
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
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          header(),
          inputName(),
          inputUsername(),
          inputEmail(),
          inputPassword(),
          submitButton(),
          const Spacer(),
          footer(),
          const SizedBox(
            height: 13,
          ),
        ],
      ),
    );
  }
}
